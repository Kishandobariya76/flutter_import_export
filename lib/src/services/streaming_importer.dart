import 'dart:async';
import '../models/models.dart';
import 'validation_engine.dart';

class CancellationToken {
  bool _isCancelled = false;
  bool get isCancelled => _isCancelled;

  void cancel() {
    _isCancelled = true;
  }
}

class ImportProgress {
  final int processedRows;
  final int totalRows;
  final double percentage;
  final int throughputRowsPerSecond;
  final String currentPhase;
  final int errorCount;
  final int warningCount;

  const ImportProgress({
    required this.processedRows,
    required this.totalRows,
    required this.percentage,
    required this.throughputRowsPerSecond,
    required this.currentPhase,
    required this.errorCount,
    required this.warningCount,
  });
}

class StreamingImporter {
  /// Execute import pipeline in chunks with live progress and cancellation support.
  static Stream<ImportProgress> runImport({
    required List<Map<String, dynamic>> rawRows,
    required DataSchema schema,
    required List<TransformationRule> transformations,
    required DuplicateStrategy duplicateStrategy,
    int chunkSize = 250,
    CancellationToken? cancellationToken,
  }) async* {
    final total = rawRows.length;
    final stopwatch = Stopwatch()..start();
    var processed = 0;
    var errors = 0;
    var warnings = 0;

    yield ImportProgress(
      processedRows: 0,
      totalRows: total,
      percentage: 0.0,
      throughputRowsPerSecond: 0,
      currentPhase: 'Initializing import stream...',
      errorCount: 0,
      warningCount: 0,
    );

    for (var i = 0; i < total; i += chunkSize) {
      if (cancellationToken?.isCancelled == true) {
        yield ImportProgress(
          processedRows: processed,
          totalRows: total,
          percentage: (processed / total).clamp(0.0, 1.0),
          throughputRowsPerSecond: (processed / (stopwatch.elapsedMilliseconds / 1000 + 0.001)).round(),
          currentPhase: 'Import cancelled by user. Rolling back batch...',
          errorCount: errors,
          warningCount: warnings,
        );
        return;
      }

      final end = (i + chunkSize < total) ? i + chunkSize : total;
      final chunk = rawRows.sublist(i, end);

      // 1. Transform
      final transformedChunk = chunk.map((row) {
        final newRow = Map<String, dynamic>.from(row);
        for (final rule in transformations) {
          if (newRow.containsKey(rule.fieldKey)) {
            newRow[rule.fieldKey] = rule.apply(newRow[rule.fieldKey]);
          }
        }
        return newRow;
      }).toList();

      // 2. Validate
      final issues = ValidationEngine.validateRecords(
        records: transformedChunk,
        schema: schema,
      );

      for (final issue in issues) {
        if (issue.severity == ErrorSeverity.error) {
          errors++;
        } else if (issue.severity == ErrorSeverity.warning) {
          warnings++;
        }
      }

      processed = end;
      final elapsedSec = stopwatch.elapsedMilliseconds / 1000;
      final throughput = (processed / (elapsedSec > 0 ? elapsedSec : 0.001)).round();

      yield ImportProgress(
        processedRows: processed,
        totalRows: total,
        percentage: (processed / total).clamp(0.0, 1.0),
        throughputRowsPerSecond: throughput,
        currentPhase: 'Processing chunk ${i ~/ chunkSize + 1} ($processed of $total rows)...',
        errorCount: errors,
        warningCount: warnings,
      );

      // Yield control for responsive UI
      await Future<void>.delayed(const Duration(milliseconds: 20));
    }

    yield ImportProgress(
      processedRows: total,
      totalRows: total,
      percentage: 1.0,
      throughputRowsPerSecond: (total / (stopwatch.elapsedMilliseconds / 1000 + 0.001)).round(),
      currentPhase: 'Import pipeline completed successfully.',
      errorCount: errors,
      warningCount: warnings,
    );
  }
}
