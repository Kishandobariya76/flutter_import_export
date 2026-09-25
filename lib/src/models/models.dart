// Core data models for flutter_import_export

/// Supported data formats for import and export.
enum DataFormat {
  csv,
  excel,
  json,
  jsonl,
}

/// Supported field data types for schema definitions.
enum FieldType {
  string,
  integer,
  decimal,
  boolean,
  dateTime,
  email,
  phone,
  url,
  enumType,
}

/// Severity level for validation issues.
enum ErrorSeverity {
  error,
  warning,
  info,
}

/// Strategy when duplicate rows are detected.
enum DuplicateStrategy {
  skip,
  overwrite,
  flag,
  fail,
}

/// Supported transformation operations on field values.
enum TransformationType {
  trim,
  lowercase,
  uppercase,
  titleCase,
  dateFormat,
  numberFormat,
  replaceNull,
  custom,
}

/// Definition of a single validation rule for a field.
class ValidationRule {
  final String id;
  final String description;
  final bool Function(dynamic value) validate;
  final ErrorSeverity severity;

  const ValidationRule({
    required this.id,
    required this.description,
    required this.validate,
    this.severity = ErrorSeverity.error,
  });

  static ValidationRule required({String? message}) => ValidationRule(
        id: 'required',
        description: message ?? 'Value is required and cannot be empty.',
        validate: (v) => v != null && v.toString().trim().isNotEmpty,
      );

  static ValidationRule email({String? message}) => ValidationRule(
        id: 'email',
        description: message ?? 'Value must be a valid email address.',
        validate: (v) {
          if (v == null || v.toString().trim().isEmpty) return true;
          final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
          return regex.hasMatch(v.toString().trim());
        },
      );

  static ValidationRule minLength(int length, {String? message}) =>
      ValidationRule(
        id: 'minLength',
        description: message ?? 'Length must be at least $length characters.',
        validate: (v) => v == null || v.toString().length >= length,
      );

  static ValidationRule range(num min, num max, {String? message}) =>
      ValidationRule(
        id: 'range',
        description: message ?? 'Value must be between $min and $max.',
        validate: (v) {
          if (v == null) return true;
          final n = num.tryParse(v.toString());
          if (n == null) return false;
          return n >= min && n <= max;
        },
      );
}

/// Schema definition for a target field.
class FieldDefinition {
  final String key;
  final String label;
  final FieldType type;
  final bool isRequired;
  final List<String> aliases;
  final List<ValidationRule> rules;
  final dynamic defaultValue;
  final String? description;

  const FieldDefinition({
    required this.key,
    required this.label,
    required this.type,
    this.isRequired = false,
    this.aliases = const [],
    this.rules = const [],
    this.defaultValue,
    this.description,
  });
}

/// Complete schema defining expected columns and types for import/export.
class DataSchema {
  final String name;
  final String? version;
  final List<FieldDefinition> fields;
  final List<String> uniqueKeys;

  const DataSchema({
    required this.name,
    this.version = '1.0.0',
    required this.fields,
    this.uniqueKeys = const [],
  });

  FieldDefinition? getField(String key) {
    try {
      return fields.firstWhere((f) => f.key == key);
    } catch (_) {
      return null;
    }
  }
}

/// Column mapping from source file column to schema target field.
class ColumnMapping {
  final String sourceColumn;
  final String? targetFieldKey;
  final double confidence;
  final bool isAutoMatched;

  const ColumnMapping({
    required this.sourceColumn,
    this.targetFieldKey,
    this.confidence = 0.0,
    this.isAutoMatched = false,
  });

  ColumnMapping copyWith({
    String? sourceColumn,
    String? targetFieldKey,
    double? confidence,
    bool? isAutoMatched,
  }) {
    return ColumnMapping(
      sourceColumn: sourceColumn ?? this.sourceColumn,
      targetFieldKey: targetFieldKey ?? this.targetFieldKey,
      confidence: confidence ?? this.confidence,
      isAutoMatched: isAutoMatched ?? this.isAutoMatched,
    );
  }
}

/// Represents a row-level validation issue.
class ValidationIssue {
  final int rowIndex;
  final String column;
  final dynamic rawValue;
  final String ruleId;
  final String message;
  final ErrorSeverity severity;
  final String? suggestion;

  const ValidationIssue({
    required this.rowIndex,
    required this.column,
    required this.rawValue,
    required this.ruleId,
    required this.message,
    this.severity = ErrorSeverity.error,
    this.suggestion,
  });
}

/// A detected duplicate record.
class DuplicateRecord {
  final int originalRowIndex;
  final int duplicateRowIndex;
  final String matchedKey;
  final Map<String, dynamic> rowData;

  const DuplicateRecord({
    required this.originalRowIndex,
    required this.duplicateRowIndex,
    required this.matchedKey,
    required this.rowData,
  });
}

/// Transformation rule applied during import.
class TransformationRule {
  final String fieldKey;
  final TransformationType type;
  final Map<String, dynamic> parameters;

  const TransformationRule({
    required this.fieldKey,
    required this.type,
    this.parameters = const {},
  });

  dynamic apply(dynamic value) {
    if (value == null) {
      if (type == TransformationType.replaceNull) {
        return parameters['replacement'] ?? '';
      }
      return null;
    }
    final str = value.toString();
    switch (type) {
      case TransformationType.trim:
        return str.trim();
      case TransformationType.lowercase:
        return str.toLowerCase();
      case TransformationType.uppercase:
        return str.toUpperCase();
      case TransformationType.titleCase:
        return str
            .split(' ')
            .map((w) => w.isEmpty
                ? ''
                : '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}')
            .join(' ');
      case TransformationType.replaceNull:
        return str;
      default:
        return value;
    }
  }
}

/// Statistics and summary of an import operation.
class ImportStatistics {
  final int totalRows;
  final int successfulRows;
  final int warningRows;
  final int errorRows;
  final int duplicateRows;
  final Duration duration;
  final double throughputRowsPerSecond;

  const ImportStatistics({
    required this.totalRows,
    required this.successfulRows,
    required this.warningRows,
    required this.errorRows,
    required this.duplicateRows,
    required this.duration,
    required this.throughputRowsPerSecond,
  });
}

/// Final result returned after an import job finishes.
class ImportResult {
  final bool isSuccess;
  final ImportStatistics statistics;
  final List<ValidationIssue> issues;
  final List<DuplicateRecord> duplicates;
  final List<Map<String, dynamic>> importedData;
  final String fileName;
  final DataFormat format;

  const ImportResult({
    required this.isSuccess,
    required this.statistics,
    required this.issues,
    required this.duplicates,
    required this.importedData,
    required this.fileName,
    required this.format,
  });
}
