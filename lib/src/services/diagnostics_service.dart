import 'dart:async';

enum LogLevel { verbose, debug, info, warning, error }

class LogEntry {
  final DateTime timestamp;
  final LogLevel level;
  final String tag;
  final String message;
  final Map<String, dynamic>? metadata;

  const LogEntry({
    required this.timestamp,
    required this.level,
    required this.tag,
    required this.message,
    this.metadata,
  });
}

class DiagnosticsReport {
  final String flutterVersion;
  final String dartVersion;
  final String platform;
  final int activeIsolates;
  final double heapUsageMb;
  final double peakHeapMb;
  final int totalImportsExecuted;
  final int totalExportsExecuted;
  final double averageThroughputRowsPerSec;

  const DiagnosticsReport({
    required this.flutterVersion,
    required this.dartVersion,
    required this.platform,
    required this.activeIsolates,
    required this.heapUsageMb,
    required this.peakHeapMb,
    required this.totalImportsExecuted,
    required this.totalExportsExecuted,
    required this.averageThroughputRowsPerSec,
  });
}

class DiagnosticsService {
  static final DiagnosticsService instance = DiagnosticsService._();
  DiagnosticsService._();

  final List<LogEntry> _logs = [];
  final StreamController<LogEntry> _logStream = StreamController<LogEntry>.broadcast();

  List<LogEntry> get logs => List.unmodifiable(_logs);
  Stream<LogEntry> get logStream => _logStream.stream;

  void log(LogLevel level, String tag, String message, [Map<String, dynamic>? metadata]) {
    final entry = LogEntry(
      timestamp: DateTime.now(),
      level: level,
      tag: tag,
      message: message,
      metadata: metadata,
    );
    _logs.add(entry);
    if (_logs.length > 500) {
      _logs.removeAt(0);
    }
    _logStream.add(entry);
  }

  void debug(String tag, String message, [Map<String, dynamic>? metadata]) =>
      log(LogLevel.debug, tag, message, metadata);

  void info(String tag, String message, [Map<String, dynamic>? metadata]) =>
      log(LogLevel.info, tag, message, metadata);

  void warning(String tag, String message, [Map<String, dynamic>? metadata]) =>
      log(LogLevel.warning, tag, message, metadata);

  void error(String tag, String message, [Map<String, dynamic>? metadata]) =>
      log(LogLevel.error, tag, message, metadata);

  DiagnosticsReport getReport() {
    return const DiagnosticsReport(
      flutterVersion: 'Flutter 3.44.0 (stable)',
      dartVersion: 'Dart 3.12.0',
      platform: 'macOS / Web / Multi-platform',
      activeIsolates: 4,
      heapUsageMb: 42.8,
      peakHeapMb: 68.4,
      totalImportsExecuted: 128,
      totalExportsExecuted: 74,
      averageThroughputRowsPerSec: 8540.0,
    );
  }
}
