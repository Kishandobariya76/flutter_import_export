class CsvProcessor {
  /// Sniff delimiter from content sample (comma, semicolon, tab, pipe).
  static String detectDelimiter(String content) {
    final lines = content
        .split(RegExp(r'\r?\n'))
        .where((l) => l.trim().isNotEmpty)
        .take(5)
        .toList();
    if (lines.isEmpty) return ',';

    final delimiters = [',', ';', '\t', '|'];
    final counts = <String, int>{};

    for (final d in delimiters) {
      counts[d] = 0;
      for (final line in lines) {
        counts[d] = counts[d]! + line.split(d).length - 1;
      }
    }

    String bestDelimiter = ',';
    int maxCount = -1;
    for (final entry in counts.entries) {
      if (entry.value > maxCount) {
        maxCount = entry.value;
        bestDelimiter = entry.key;
      }
    }
    return bestDelimiter;
  }

  /// Parse CSV string into list of rows according to RFC-4180.
  static List<List<dynamic>> parseCsv(String content, {String? delimiter}) {
    if (content.isEmpty) return [];

    final delim = delimiter ?? detectDelimiter(content);
    final delimCode = delim.codeUnitAt(0);
    final rows = <List<dynamic>>[];
    var currentRow = <dynamic>[];
    final buffer = StringBuffer();
    var inQuotes = false;
    final length = content.length;

    dynamic parseValue(String val) {
      if (val.isEmpty) return '';
      final intVal = int.tryParse(val);
      if (intVal != null) return intVal;
      final doubleVal = double.tryParse(val);
      if (doubleVal != null) return doubleVal;
      return val;
    }

    void finishField() {
      currentRow.add(parseValue(buffer.toString()));
      buffer.clear();
    }

    void finishRow() {
      finishField();
      // Skip empty trailing rows
      if (currentRow.length > 1 || (currentRow.length == 1 && currentRow[0] != '')) {
        rows.add(currentRow);
      }
      currentRow = <dynamic>[];
    }

    for (var i = 0; i < length; i++) {
      final code = content.codeUnitAt(i);

      if (inQuotes) {
        if (code == 34) { // quote '"'
          if (i + 1 < length && content.codeUnitAt(i + 1) == 34) {
            buffer.write('"');
            i++; // skip escaped quote
          } else {
            inQuotes = false;
          }
        } else {
          buffer.writeCharCode(code);
        }
      } else {
        if (code == 34) { // quote '"'
          inQuotes = true;
        } else if (code == delimCode) {
          finishField();
        } else if (code == 10) { // '\n'
          finishRow();
        } else if (code == 13) { // '\r'
          if (i + 1 < length && content.codeUnitAt(i + 1) == 10) {
            i++; // skip '\n' following '\r'
          }
          finishRow();
        } else {
          buffer.writeCharCode(code);
        }
      }
    }

    if (buffer.isNotEmpty || inQuotes || currentRow.isNotEmpty) {
      finishField();
      if (currentRow.length > 1 || (currentRow.length == 1 && currentRow[0] != '')) {
        rows.add(currentRow);
      }
    }

    return rows;
  }

  /// Convert structured data to CSV string according to RFC-4180.
  static String exportCsv({
    required List<String> headers,
    required List<List<dynamic>> rows,
    String delimiter = ',',
    bool quoteAllFields = false,
  }) {
    final buffer = StringBuffer();

    String formatCell(dynamic cell) {
      final str = cell?.toString() ?? '';
      final needsQuotes = quoteAllFields ||
          str.contains(delimiter) ||
          str.contains('"') ||
          str.contains('\n') ||
          str.contains('\r');

      if (needsQuotes) {
        final escaped = str.replaceAll('"', '""');
        return '"$escaped"';
      }
      return str;
    }

    buffer.writeln(headers.map(formatCell).join(delimiter));
    for (final row in rows) {
      buffer.writeln(row.map(formatCell).join(delimiter));
    }

    return buffer.toString();
  }
}
