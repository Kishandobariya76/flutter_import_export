import '../models/models.dart';

class ValidationEngine {
  /// Validate a batch of mapped records against schema rules.
  static List<ValidationIssue> validateRecords({
    required List<Map<String, dynamic>> records,
    required DataSchema schema,
  }) {
    final issues = <ValidationIssue>[];

    for (var rIdx = 0; rIdx < records.length; rIdx++) {
      final row = records[rIdx];

      for (final field in schema.fields) {
        final val = row[field.key];

        // 1. Required check
        if (field.isRequired && (val == null || val.toString().trim().isEmpty)) {
          issues.add(ValidationIssue(
            rowIndex: rIdx + 1,
            column: field.label,
            rawValue: val,
            ruleId: 'required',
            message: 'Required field "${field.label}" cannot be empty.',
            severity: ErrorSeverity.error,
            suggestion: 'Provide a valid ${field.type.name} value.',
          ));
          continue;
        }

        if (val == null || val.toString().trim().isEmpty) {
          continue;
        }

        // 2. Type checks
        final strVal = val.toString().trim();
        switch (field.type) {
          case FieldType.integer:
            if (int.tryParse(strVal) == null) {
              issues.add(ValidationIssue(
                rowIndex: rIdx + 1,
                column: field.label,
                rawValue: val,
                ruleId: 'type_integer',
                message: 'Value "$strVal" is not a valid integer.',
                severity: ErrorSeverity.error,
                suggestion: 'Ensure the column contains whole numbers only.',
              ));
            }
            break;
          case FieldType.decimal:
            if (double.tryParse(strVal) == null) {
              issues.add(ValidationIssue(
                rowIndex: rIdx + 1,
                column: field.label,
                rawValue: val,
                ruleId: 'type_decimal',
                message: 'Value "$strVal" is not a valid decimal number.',
                severity: ErrorSeverity.error,
              ));
            }
            break;
          case FieldType.boolean:
            final lower = strVal.toLowerCase();
            if (!['true', 'false', '1', '0', 'yes', 'no'].contains(lower)) {
              issues.add(ValidationIssue(
                rowIndex: rIdx + 1,
                column: field.label,
                rawValue: val,
                ruleId: 'type_boolean',
                message: 'Value "$strVal" cannot be parsed as a boolean.',
                severity: ErrorSeverity.warning,
                suggestion: 'Use true/false, yes/no, or 1/0.',
              ));
            }
            break;
          case FieldType.email:
            final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
            if (!emailRegex.hasMatch(strVal)) {
              issues.add(ValidationIssue(
                rowIndex: rIdx + 1,
                column: field.label,
                rawValue: val,
                ruleId: 'type_email',
                message: 'Value "$strVal" is not a valid email syntax.',
                severity: ErrorSeverity.error,
                suggestion: 'Check for missing @ or domain (e.g. name@domain.com).',
              ));
            }
            break;
          default:
            break;
        }

        // 3. Custom rules
        for (final rule in field.rules) {
          try {
            if (!rule.validate(val)) {
              issues.add(ValidationIssue(
                rowIndex: rIdx + 1,
                column: field.label,
                rawValue: val,
                ruleId: rule.id,
                message: rule.description,
                severity: rule.severity,
              ));
            }
          } catch (e) {
            issues.add(ValidationIssue(
              rowIndex: rIdx + 1,
              column: field.label,
              rawValue: val,
              ruleId: rule.id,
              message: 'Evaluation failed: $e',
              severity: ErrorSeverity.error,
            ));
          }
        }
      }
    }

    return issues;
  }
}
