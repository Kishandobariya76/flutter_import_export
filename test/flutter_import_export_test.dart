import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_import_export/flutter_import_export.dart';

void main() {
  group('flutter_import_export package tests', () {
    const customerSchema = DataSchema(
      name: 'Customer Schema',
      fields: [
        FieldDefinition(
          key: 'name',
          label: 'Customer Name',
          type: FieldType.string,
          isRequired: true,
          aliases: ['full_name', 'client_name', 'name'],
        ),
        FieldDefinition(
          key: 'email',
          label: 'Email',
          type: FieldType.email,
          isRequired: true,
          aliases: ['e_mail', 'contact_email'],
        ),
        FieldDefinition(
          key: 'company',
          label: 'Company',
          type: FieldType.string,
          aliases: ['org', 'organization'],
        ),
      ],
      uniqueKeys: ['email'],
    );

    test('SmartMatcher finds exact and alias matches', () {
      final matches = SmartMatcher.matchColumns(
        sourceColumns: ['Full Name', 'contact_email', 'Organization'],
        schema: customerSchema,
      );

      expect(matches.length, equals(3));
      expect(matches[0].targetFieldKey, equals('name'));
      expect(matches[1].targetFieldKey, equals('email'));
      expect(matches[2].targetFieldKey, equals('company'));
    });

    test('CsvProcessor parses CSV and detects delimiter', () {
      const csvData = 'name,email,company\nAlex Johnson,alex@example.com,Demo Corp\n';
      final delimiter = CsvProcessor.detectDelimiter(csvData);
      expect(delimiter, equals(','));

      final rows = CsvProcessor.parseCsv(csvData);
      expect(rows.length, equals(2));
      expect(rows[1][0], equals('Alex Johnson'));
    });

    test('ValidationEngine flags invalid emails and missing required fields', () {
      final records = [
        {'name': 'Alex Johnson', 'email': 'alex@example.com', 'company': 'Demo Corp'},
        {'name': '', 'email': 'not-an-email', 'company': 'Acme'},
      ];

      final issues = ValidationEngine.validateRecords(
        records: records,
        schema: customerSchema,
      );

      expect(issues.length, greaterThanOrEqualTo(2));
      expect(issues.any((i) => i.ruleId == 'required'), isTrue);
      expect(issues.any((i) => i.ruleId == 'type_email'), isTrue);
    });

    test('DuplicateDetector detects duplicate records by unique key', () {
      final records = [
        {'name': 'Alex Johnson', 'email': 'alex@example.com', 'company': 'Demo Corp'},
        {'name': 'Alexander J.', 'email': 'alex@example.com', 'company': 'Demo Inc'},
      ];

      final duplicates = DuplicateDetector.findDuplicates(
        records: records,
        uniqueKeys: ['email'],
      );

      expect(duplicates.length, equals(1));
      expect(duplicates.first.originalRowIndex, equals(1));
      expect(duplicates.first.duplicateRowIndex, equals(2));
    });
  });
}
