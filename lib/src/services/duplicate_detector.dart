import '../models/models.dart';

class DuplicateDetector {
  /// Detect duplicate rows based on unique key fields or full row comparison.
  static List<DuplicateRecord> findDuplicates({
    required List<Map<String, dynamic>> records,
    required List<String> uniqueKeys,
  }) {
    final duplicates = <DuplicateRecord>[];
    final seenKeys = <String, int>{}; // compositeKey -> firstRowIndex

    for (var i = 0; i < records.length; i++) {
      final row = records[i];
      final keyParts = <String>[];

      if (uniqueKeys.isNotEmpty) {
        for (final k in uniqueKeys) {
          final val = row[k]?.toString().trim().toLowerCase() ?? '';
          keyParts.add('$k:$val');
        }
      } else {
        // Fallback to all values
        for (final entry in row.entries) {
          keyParts.add('${entry.key}:${entry.value?.toString().trim().toLowerCase()}');
        }
      }

      final compositeKey = keyParts.join('|');

      if (seenKeys.containsKey(compositeKey)) {
        duplicates.add(DuplicateRecord(
          originalRowIndex: seenKeys[compositeKey]! + 1,
          duplicateRowIndex: i + 1,
          matchedKey: compositeKey,
          rowData: row,
        ));
      } else {
        seenKeys[compositeKey] = i;
      }
    }

    return duplicates;
  }
}
