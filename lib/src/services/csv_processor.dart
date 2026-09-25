import 'package:csv/csv.dart';

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

  /// Parse CSV string into list of rows.
  static List<List<dynamic>> parseCsv(String content, {String? delimiter}) {
    final delim = delimiter ?? detectDelimiter(content);
    final parser = Csv(
      fieldDelimiter: delim,
      autoDetect: delimiter == null,
      skipEmptyLines: true,
    );
    return parser.decode(content);
  }

  /// Convert structured data to CSV string.
  static String exportCsv({
    required List<String> headers,
    required List<List<dynamic>> rows,
    String delimiter = ',',
    bool quoteAllFields = false,
  }) {
    final encoder = Csv(
      fieldDelimiter: delimiter,
      quoteMode: quoteAllFields ? QuoteMode.always : QuoteMode.necessary,
    );
    return encoder.encode([headers, ...rows]);
  }
}
