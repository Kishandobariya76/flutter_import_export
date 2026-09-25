import 'dart:math' as math;
import '../models/models.dart';

class SmartMatcher {
  /// Match source columns against schema fields using exact, alias, and fuzzy similarity.
  static List<ColumnMapping> matchColumns({
    required List<String> sourceColumns,
    required DataSchema schema,
    double threshold = 0.5,
  }) {
    final mappings = <ColumnMapping>[];
    final usedFields = <String>{};

    for (final src in sourceColumns) {
      final normalizedSrc = _normalize(src);
      String? bestFieldKey;
      double bestScore = 0.0;

      for (final field in schema.fields) {
        if (usedFields.contains(field.key)) continue;

        // 1. Exact match on field key or label
        final normKey = _normalize(field.key);
        final normLabel = _normalize(field.label);
        if (normalizedSrc == normKey || normalizedSrc == normLabel) {
          bestScore = 1.0;
          bestFieldKey = field.key;
          break;
        }

        // 2. Exact match on alias
        for (final alias in field.aliases) {
          if (normalizedSrc == _normalize(alias)) {
            bestScore = 0.98;
            bestFieldKey = field.key;
            break;
          }
        }
        if (bestScore >= 0.98) break;

        // 3. Substring matching
        if (normLabel.contains(normalizedSrc) || normalizedSrc.contains(normLabel)) {
          final score = 0.85;
          if (score > bestScore) {
            bestScore = score;
            bestFieldKey = field.key;
          }
        }

        // 4. Fuzzy similarity score
        final simKey = _calculateSimilarity(normalizedSrc, normKey);
        final simLabel = _calculateSimilarity(normalizedSrc, normLabel);
        final sim = math.max(simKey, simLabel);

        if (sim > bestScore && sim >= threshold) {
          bestScore = sim;
          bestFieldKey = field.key;
        }
      }

      if (bestFieldKey != null && bestScore >= threshold) {
        usedFields.add(bestFieldKey);
        mappings.add(ColumnMapping(
          sourceColumn: src,
          targetFieldKey: bestFieldKey,
          confidence: bestScore,
          isAutoMatched: true,
        ));
      } else {
        mappings.add(ColumnMapping(
          sourceColumn: src,
          targetFieldKey: null,
          confidence: 0.0,
          isAutoMatched: false,
        ));
      }
    }

    return mappings;
  }

  static String _normalize(String input) {
    return input
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]'), '')
        .trim();
  }

  static double _calculateSimilarity(String s1, String s2) {
    if (s1.isEmpty && s2.isEmpty) return 1.0;
    if (s1.isEmpty || s2.isEmpty) return 0.0;
    if (s1 == s2) return 1.0;

    final distance = _levenshteinDistance(s1, s2);
    final maxLen = math.max(s1.length, s2.length);
    return 1.0 - (distance / maxLen);
  }

  static int _levenshteinDistance(String s1, String s2) {
    final m = s1.length;
    final n = s2.length;
    final dp = List.generate(m + 1, (_) => List.filled(n + 1, 0));

    for (var i = 0; i <= m; i++) {
      dp[i][0] = i;
    }
    for (var j = 0; j <= n; j++) {
      dp[0][j] = j;
    }

    for (var i = 1; i <= m; i++) {
      for (var j = 1; j <= n; j++) {
        final cost = s1[i - 1] == s2[j - 1] ? 0 : 1;
        dp[i][j] = math.min(
          dp[i - 1][j] + 1,
          math.min(dp[i][j - 1] + 1, dp[i - 1][j - 1] + cost),
        );
      }
    }
    return dp[m][n];
  }
}
