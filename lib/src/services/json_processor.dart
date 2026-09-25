import 'dart:convert';

class JsonProcessor {
  /// Parse JSON string or JSONL into rows.
  static List<Map<String, dynamic>> parseJson(String content) {
    final trimmed = content.trim();
    if (trimmed.startsWith('[')) {
      final decoded = jsonDecode(trimmed);
      if (decoded is List) {
        return decoded.map((e) => Map<String, dynamic>.from(e as Map)).toList();
      }
    } else if (trimmed.startsWith('{')) {
      final decoded = jsonDecode(trimmed);
      if (decoded is Map) {
        // Look for common array keys
        for (final key in ['data', 'items', 'rows', 'records', 'customers', 'users', 'results']) {
          if (decoded.containsKey(key) && decoded[key] is List) {
            return (decoded[key] as List)
                .map((e) => Map<String, dynamic>.from(e as Map))
                .toList();
          }
        }
        return [Map<String, dynamic>.from(decoded)];
      }
    }

    // Attempt JSON Lines (JSONL)
    final lines = trimmed.split(RegExp(r'\r?\n')).where((l) => l.trim().isNotEmpty);
    final results = <Map<String, dynamic>>[];
    for (final line in lines) {
      try {
        final decoded = jsonDecode(line);
        if (decoded is Map) {
          results.add(Map<String, dynamic>.from(decoded));
        }
      } catch (_) {}
    }
    return results;
  }

  /// Export records to formatted JSON string.
  static String exportJson({
    required List<Map<String, dynamic>> records,
    bool prettyPrint = true,
  }) {
    if (prettyPrint) {
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(records);
    }
    return jsonEncode(records);
  }
}
