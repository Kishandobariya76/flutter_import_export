import 'package:flutter/material.dart';
import '../data/demo_data.dart';
import '../widgets/app_theme.dart';

/// Screen for CSV Import Configuration
class ImportCsvScreen extends StatelessWidget {
  final ValueChanged<String>? onNavigate;

  const ImportCsvScreen({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(
            title: 'CSV Import Configuration',
            description: 'Configure delimiter detection, quote characters, text encodings, and row offset for CSV ingestion.',
            icon: Icons.format_align_left_rounded,
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Column: Parameters
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceDark,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppTheme.borderDark),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'File Ingestion Parameters',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
                      ),
                      const SizedBox(height: 16),
                      _buildFileCard(fileName: 'customers.csv', fileSize: '482.4 KB (10,000 rows)', format: 'Comma-Separated Values'),
                      const SizedBox(height: 20),
                      _buildDropdownRow('Delimiter Sniffer', 'Auto-Detect (Detected: , Comma)', ['Auto-Detect (Detected: , Comma)', 'Comma (,)', 'Semicolon (;)', 'Tab (\\t)', 'Pipe (|)']),
                      const SizedBox(height: 14),
                      _buildDropdownRow('Text Encoding', 'UTF-8 (Auto-detected)', ['UTF-8 (Auto-detected)', 'UTF-16 LE', 'ISO-8859-1', 'Windows-1252']),
                      const SizedBox(height: 14),
                      _buildDropdownRow('Quote Character', 'Double Quote (")', ['Double Quote (")', 'Single Quote (\')', 'None']),
                      const SizedBox(height: 14),
                      _buildDropdownRow('Header Row Index', 'Row 1 (First line is header)', ['Row 1 (First line is header)', 'Row 2 (Metadata on Row 1)', 'No Header (Auto-generate col1..colN)']),
                      const SizedBox(height: 16),
                      const Divider(color: AppTheme.borderDark),
                      const SizedBox(height: 12),
                      _buildToggleRow('Skip Empty Lines', 'Automatically ignore blank rows in the stream', true),
                      const SizedBox(height: 8),
                      _buildToggleRow('Trim Leading/Trailing Whitespace', 'Strip whitespace around unquoted fields', true),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => onNavigate?.call('file_preview'),
                            icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                            label: const Text('Parse & Preview Dataset'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryAccent,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                            ),
                          ),
                          const SizedBox(width: 12),
                          OutlinedButton(
                            onPressed: () => onNavigate?.call('dashboard'),
                            style: OutlinedButton.styleFrom(foregroundColor: AppTheme.textSecondary),
                            child: const Text('Cancel'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              // Right Column: Live Raw Stream Preview
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceDark,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppTheme.borderDark),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.terminal_rounded, size: 18, color: AppTheme.primaryBlue),
                          SizedBox(width: 8),
                          Text('Raw Stream First 5 Lines', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(14),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppTheme.cardDark,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppTheme.borderDark),
                        ),
                        child: const Text(
                          'id,name,email,company,revenue,status\n1001,"Alex Johnson",alex@example.com,"Demo Corporation",125000,ACTIVE\n1002,"Sarah Connor",sarah@techcorp.io,"TechCorp Solutions",84000,ACTIVE\n1003,"Marcus Chen",m.chen@apexanalytics.com,"Apex Analytics",210000,PENDING\n1004,"Emily Davis",emily.davis@summithealth.org,"Summit Health",95000,ACTIVE',
                          style: TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 12,
                            color: Color(0xFF58A6FF),
                            height: 1.6,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildInfoBanner('Engine will stream in chunks of 250 rows to optimize memory latency on web and mobile.'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Screen for Excel Import Configuration
class ImportExcelScreen extends StatelessWidget {
  final ValueChanged<String>? onNavigate;

  const ImportExcelScreen({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(
            title: 'Excel / Spreadsheet Import',
            description: 'Read multi-sheet XLSX and XLS workbooks, evaluate formulas, and inspect table structure.',
            icon: Icons.grid_on_rounded,
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.surfaceDark,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.borderDark),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFileCard(fileName: 'customers.xlsx', fileSize: '814.2 KB (10,000 rows across 3 sheets)', format: 'Microsoft Excel OpenXML (.xlsx)'),
                const SizedBox(height: 20),
                const Text('Detected Worksheets', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildSheetCard('Customers (Active)', '10,000 rows • 6 cols', true),
                    const SizedBox(width: 12),
                    _buildSheetCard('Archived Accounts', '2,450 rows • 6 cols', false),
                    const SizedBox(width: 12),
                    _buildSheetCard('Schema_Metadata', '18 rows • 3 cols', false),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(color: AppTheme.borderDark),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: _buildDropdownRow('Header Row Index', 'Row 1 (Top Header)', ['Row 1 (Top Header)', 'Row 2', 'Row 3'])),
                    const SizedBox(width: 20),
                    Expanded(child: _buildDropdownRow('Date Format Handling', 'ISO-8601 (YYYY-MM-DD)', ['ISO-8601 (YYYY-MM-DD)', 'Excel Serial Number', 'US (MM/DD/YYYY)'])),
                  ],
                ),
                const SizedBox(height: 14),
                _buildToggleRow('Evaluate Formulas to Computed Values', 'Extract calculated cell results instead of raw formulas like =SUM(...)', true),
                const SizedBox(height: 8),
                _buildToggleRow('Ignore Hidden Rows & Filtered Out Rows', 'Do not ingest rows marked as hidden in Excel view', true),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => onNavigate?.call('file_preview'),
                  icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                  label: const Text('Inspect Sheet & Preview Data'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF107C41),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSheetCard(String name, String details, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF107C41).withValues(alpha: 0.15) : AppTheme.cardDark,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? const Color(0xFF107C41) : AppTheme.borderDark,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.table_chart_outlined, size: 20, color: isSelected ? const Color(0xFF3FB950) : AppTheme.textMuted),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: isSelected ? Colors.white : AppTheme.textPrimary)),
              Text(details, style: const TextStyle(fontSize: 11, color: AppTheme.textMuted)),
            ],
          ),
          if (isSelected) ...[
            const SizedBox(width: 10),
            const Icon(Icons.check_circle, size: 16, color: Color(0xFF3FB950)),
          ],
        ],
      ),
    );
  }
}

/// Screen for JSON / JSONL Import Configuration
class ImportJsonScreen extends StatelessWidget {
  final ValueChanged<String>? onNavigate;

  const ImportJsonScreen({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(
            title: 'JSON / JSONL Import Configuration',
            description: 'Extract datasets from JSON arrays or newline-delimited JSON with JSONPath traversal and flattening.',
            icon: Icons.data_object_rounded,
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.surfaceDark,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.borderDark),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFileCard(fileName: 'customers.json', fileSize: '1.24 MB (10,000 objects)', format: 'JSON Structured Object Envelope'),
                const SizedBox(height: 20),
                _buildDropdownRow('Root JSONPath Array Selector', r'$.data.customers[*]', [r'$.data.customers[*]', r'$[*]', r'$.items[*]']),
                const SizedBox(height: 16),
                _buildToggleRow('Flatten Nested Objects', 'Convert nested objects like {"company": {"name": "..."}} to company_name', true),
                const SizedBox(height: 8),
                _buildToggleRow('Convert Arrays to Delimited Strings', 'Join primitive arrays like ["tag1", "tag2"] into "tag1, tag2"', true),
                const SizedBox(height: 20),
                const Text('Payload Structure Inspection', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.cardDark,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppTheme.borderDark),
                  ),
                  child: const Text(
                    '{\n  "status": "success",\n  "total": 10000,\n  "data": {\n    "customers": [\n      {"id": 1001, "name": "Alex Johnson", "email": "alex@example.com", "company": "Demo Corp", "revenue": 125000, "status": "ACTIVE"},\n      {"id": 1002, "name": "Sarah Connor", "email": "sarah@techcorp.io", "company": "TechCorp", "revenue": 84000, "status": "ACTIVE"}\n    ]\n  }\n}',
                    style: TextStyle(fontFamily: 'Courier', fontSize: 12, color: Color(0xFFF16529), height: 1.4),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => onNavigate?.call('file_preview'),
                  icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                  label: const Text('Parse JSON & Preview Table'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF16529),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Screen for File Data Preview
class FilePreviewScreen extends StatelessWidget {
  final ValueChanged<String>? onNavigate;

  const FilePreviewScreen({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildHeader(
                title: 'Data Preview: customers.xlsx',
                description: 'First 100 rows rendered. Showing column types, non-null percentages, and raw sample records.',
                icon: Icons.preview_rounded,
              ),
              Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: () => onNavigate?.call('import_csv'),
                    icon: const Icon(Icons.arrow_back, size: 16),
                    label: const Text('Back to Setup'),
                    style: OutlinedButton.styleFrom(foregroundColor: AppTheme.textSecondary),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () => onNavigate?.call('column_mapping'),
                    icon: const Icon(Icons.schema_rounded, size: 16),
                    label: const Text('Proceed to Column Mapping'),
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryAccent, foregroundColor: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Stats Row
          Row(
            children: [
              _buildMiniStat('Total Records', '10,000', Icons.dataset_rounded, AppTheme.primaryBlue),
              const SizedBox(width: 12),
              _buildMiniStat('Detected Columns', '6 Fields', Icons.view_column_rounded, AppTheme.successGreen),
              const SizedBox(width: 12),
              _buildMiniStat('Null Value Density', '0.04%', Icons.check_circle_outline, const Color(0xFFA371F7)),
              const SizedBox(width: 12),
              _buildMiniStat('Encoding / Delimiter', 'UTF-8 / Tabular', Icons.code_rounded, AppTheme.textSecondary),
            ],
          ),
          const SizedBox(height: 20),
          // Data Table
          Container(
            decoration: BoxDecoration(
              color: AppTheme.surfaceDark,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.borderDark),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: WidgetStateProperty.all(AppTheme.cardDark),
                  dataRowColor: WidgetStateProperty.resolveWith(
                    (states) => states.contains(WidgetState.hovered) ? AppTheme.cardDark.withValues(alpha: 0.5) : AppTheme.surfaceDark,
                  ),
                  columnSpacing: 28,
                  headingTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textPrimary, fontSize: 13),
                  dataTextStyle: const TextStyle(color: AppTheme.textSecondary, fontSize: 13),
                  columns: const [
                    DataColumn(label: Text('Row #')),
                    DataColumn(label: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [Text('id'), Text('INTEGER', style: TextStyle(fontSize: 10, color: AppTheme.primaryBlue))])),
                    DataColumn(label: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [Text('name'), Text('STRING', style: TextStyle(fontSize: 10, color: AppTheme.primaryBlue))])),
                    DataColumn(label: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [Text('email'), Text('EMAIL', style: TextStyle(fontSize: 10, color: AppTheme.primaryBlue))])),
                    DataColumn(label: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [Text('company'), Text('STRING', style: TextStyle(fontSize: 10, color: AppTheme.primaryBlue))])),
                    DataColumn(label: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [Text('revenue'), Text('DECIMAL', style: TextStyle(fontSize: 10, color: AppTheme.primaryBlue))])),
                    DataColumn(label: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [Text('status'), Text('ENUM', style: TextStyle(fontSize: 10, color: AppTheme.primaryBlue))])),
                  ],
                  rows: DemoData.sampleRows.asMap().entries.map((entry) {
                    final index = entry.key + 1;
                    final row = entry.value;
                    return DataRow(
                      cells: [
                        DataCell(Text('$index', style: const TextStyle(color: AppTheme.textMuted, fontWeight: FontWeight.bold))),
                        DataCell(Text('${row['id']}')),
                        DataCell(Text('${row['name']}', style: const TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.w500))),
                        DataCell(Text('${row['email']}')),
                        DataCell(Text('${row['company']}')),
                        DataCell(Text('\$${(row['revenue'] as double).toStringAsFixed(2)}')),
                        DataCell(_buildStatusBadge(row['status'] as String)),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStat(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: AppTheme.surfaceDark,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppTheme.borderDark),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 11, color: AppTheme.textMuted)),
                Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    final isPending = status == 'PENDING';
    final isInactive = status == 'INACTIVE';
    final color = isPending ? AppTheme.warningAmber : (isInactive ? AppTheme.errorRed : AppTheme.successGreen);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        status,
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// Shared UI Helpers
Widget _buildHeader({required String title, required String description, required IconData icon}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(icon, color: AppTheme.primaryBlue, size: 24),
          const SizedBox(width: 10),
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
        ],
      ),
      const SizedBox(height: 6),
      Text(description, style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
    ],
  );
}

Widget _buildFileCard({required String fileName, required String fileSize, required String format}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: AppTheme.cardDark,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: AppTheme.borderDark),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.primaryAccent.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Icon(Icons.insert_drive_file_outlined, color: AppTheme.primaryBlue, size: 24),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(fileName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppTheme.textPrimary)),
            const SizedBox(height: 2),
            Text('$fileSize • $format', style: const TextStyle(fontSize: 12, color: AppTheme.textMuted)),
          ],
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppTheme.successGreen.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text('VALIDATED', style: TextStyle(color: AppTheme.successGreen, fontSize: 11, fontWeight: FontWeight.bold)),
        ),
      ],
    ),
  );
}

Widget _buildDropdownRow(String label, String value, List<String> options) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.textSecondary)),
      const SizedBox(height: 6),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: AppTheme.cardDark,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppTheme.borderDark),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            dropdownColor: AppTheme.surfaceDark,
            style: const TextStyle(color: AppTheme.textPrimary, fontSize: 13),
            items: options.map((opt) => DropdownMenuItem(value: opt, child: Text(opt))).toList(),
            onChanged: (_) {},
          ),
        ),
      ),
    ],
  );
}

Widget _buildToggleRow(String title, String subtitle, bool isChecked) {
  return Row(
    children: [
      Switch(
        value: isChecked,
        onChanged: (_) {},
        activeThumbColor: AppTheme.primaryBlue,
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textPrimary)),
            Text(subtitle, style: const TextStyle(fontSize: 11, color: AppTheme.textMuted)),
          ],
        ),
      ),
    ],
  );
}

Widget _buildInfoBanner(String text) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: AppTheme.primaryAccent.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: AppTheme.primaryBlue.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        const Icon(Icons.info_outline, size: 16, color: AppTheme.primaryBlue),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12))),
      ],
    ),
  );
}
