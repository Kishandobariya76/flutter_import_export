import 'package:flutter_import_export/flutter_import_export.dart';

class DemoData {
  static const int totalImports = 128;
  static const int totalExports = 74;
  static const int totalErrors = 12;

  static const String recentFileName = 'customers.xlsx';
  static const int recentTotalRows = 10000;
  static const int recentSuccessfulRows = 9842;
  static const int recentWarningRows = 112;
  static const int recentErrorRows = 46;
  static const double recentThroughput = 8540.0;
  static const String recentDuration = '1.15s';

  static const customerSchema = DataSchema(
    name: 'Customer Schema',
    version: '1.2.0',
    fields: [
      FieldDefinition(
        key: 'id',
        label: 'Customer ID',
        type: FieldType.integer,
        isRequired: true,
        aliases: ['cust_id', 'id', 'account_id'],
      ),
      FieldDefinition(
        key: 'name',
        label: 'Customer Name',
        type: FieldType.string,
        isRequired: true,
        aliases: ['full_name', 'client_name', 'name', 'contact_name'],
      ),
      FieldDefinition(
        key: 'email',
        label: 'Email',
        type: FieldType.email,
        isRequired: true,
        aliases: ['e_mail', 'contact_email', 'email_address'],
      ),
      FieldDefinition(
        key: 'company',
        label: 'Company',
        type: FieldType.string,
        isRequired: false,
        aliases: ['org', 'organization', 'company_name', 'employer'],
      ),
      FieldDefinition(
        key: 'revenue',
        label: 'Annual Revenue',
        type: FieldType.decimal,
        isRequired: false,
        aliases: ['annual_revenue', 'rev', 'sales', 'arr'],
      ),
      FieldDefinition(
        key: 'status',
        label: 'Account Status',
        type: FieldType.enumType,
        isRequired: true,
        aliases: ['account_status', 'state', 'customer_status'],
      ),
    ],
    uniqueKeys: ['email'],
  );

  static final List<Map<String, dynamic>> sampleRows = [
    {
      'id': 1001,
      'name': 'Alex Johnson',
      'email': 'alex@example.com',
      'company': 'Demo Corporation',
      'revenue': 125000.0,
      'status': 'ACTIVE',
    },
    {
      'id': 1002,
      'name': 'Sarah Connor',
      'email': 'sarah@techcorp.io',
      'company': 'TechCorp Solutions',
      'revenue': 84000.0,
      'status': 'ACTIVE',
    },
    {
      'id': 1003,
      'name': 'Marcus Chen',
      'email': 'm.chen@apexanalytics.com',
      'company': 'Apex Analytics',
      'revenue': 210000.0,
      'status': 'PENDING',
    },
    {
      'id': 1004,
      'name': 'Emily Davis',
      'email': 'emily.davis@summithealth.org',
      'company': 'Summit Health',
      'revenue': 95000.0,
      'status': 'ACTIVE',
    },
    {
      'id': 1005,
      'name': 'David Miller',
      'email': 'd.miller@vanguardlogistics.com',
      'company': 'Vanguard Logistics',
      'revenue': 310000.0,
      'status': 'INACTIVE',
    },
    {
      'id': 1006,
      'name': 'Jessica Taylor',
      'email': 'jessica@quantumcloud.net',
      'company': 'Quantum Cloud',
      'revenue': 148000.0,
      'status': 'ACTIVE',
    },
    {
      'id': 1007,
      'name': 'Robert Martinez',
      'email': 'robert@nexusglobal.com',
      'company': 'Nexus Global',
      'revenue': 76000.0,
      'status': 'ACTIVE',
    },
    {
      'id': 1008,
      'name': 'Amanda White',
      'email': 'a.white@solardynamics.io',
      'company': 'Solar Dynamics',
      'revenue': 185000.0,
      'status': 'ACTIVE',
    },
  ];
}
