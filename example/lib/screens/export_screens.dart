import 'package:flutter/material.dart';
import '../widgets/app_theme.dart';

/// Screen for CSV Export Configuration
class ExportCsvScreen extends StatelessWidget {
  final ValueChanged<String>? onNavigate;

  const ExportCsvScreen({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;

        final paramsCard = Container(
          padding: EdgeInsets.all(isMobile ? 16 : 20),
          decoration: BoxDecoration(
            color: AppTheme.surfaceDark,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppTheme.borderDark),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Export Parameters', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
              const SizedBox(height: 16),
              _buildDropdownRow('Field Delimiter', 'Comma (,)', ['Comma (,)', 'Semicolon (;)', 'Tab (\\t)', 'Pipe (|)']),
              const SizedBox(height: 14),
              _buildDropdownRow('Quote Mode', 'Quote Only Necessary (Standard RFC-4180)', ['Quote Only Necessary (Standard RFC-4180)', 'Always Quote All Fields', 'Never Quote']),
              const SizedBox(height: 14),
              _buildDropdownRow('Line Endings', 'CRLF (\\r\\n - Windows / Excel Default)', ['CRLF (\\r\\n - Windows / Excel Default)', 'LF (\\n - Unix/macOS)']),
              const SizedBox(height: 14),
              _buildToggleRow('Add UTF-8 Byte Order Mark (BOM)', 'Ensures accented characters render correctly in Microsoft Excel', true),
              const SizedBox(height: 10),
              _buildToggleRow('Include Header Row', 'Write column names on line 1 of the output file', true),
              const SizedBox(height: 20),
              const Divider(color: AppTheme.borderDark),
              const SizedBox(height: 16),
              const Text('Included Fields (5 Selected)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildFieldCheckChip('id (Customer ID)', true),
                  _buildFieldCheckChip('name (Customer Name)', true),
                  _buildFieldCheckChip('email (Email)', true),
                  _buildFieldCheckChip('company (Company)', true),
                  _buildFieldCheckChip('revenue (Revenue)', true),
                  _buildFieldCheckChip('status (Status)', true),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download_rounded, size: 16),
                  label: const Text('Export & Download customers.csv (9,842 rows)'),
                  style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryAccent, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14)),
                ),
              ),
            ],
          ),
        );

        final previewCard = Container(
          padding: EdgeInsets.all(isMobile ? 16 : 20),
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
                  Icon(Icons.visibility_outlined, size: 18, color: AppTheme.primaryBlue),
                  SizedBox(width: 8),
                  Text('Output File Preview', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(color: AppTheme.cardDark, borderRadius: BorderRadius.circular(6), border: Border.all(color: AppTheme.borderDark)),
                child: const Text(
                  'id,name,email,company,revenue,status\r\n1001,"Alex Johnson",alex@example.com,"Demo Corporation",125000.00,ACTIVE\r\n1002,"Sarah Connor",sarah@techcorp.io,"TechCorp Solutions",84000.00,ACTIVE\r\n1003,"Marcus Chen",m.chen@apexanalytics.com,"Apex Analytics",210000.00,PENDING\r\n1004,"Emily Davis",emily.davis@summithealth.org,"Summit Health",95000.00,ACTIVE',
                  style: TextStyle(fontFamily: 'Courier', fontSize: 11, color: Color(0xFF58A6FF), height: 1.5),
                ),
              ),
              const SizedBox(height: 16),
              _buildInfoTile('Estimated File Size', '472 KB (Uncompressed)'),
              _buildInfoTile('Throughput', '18,500 rows/second generation speed'),
            ],
          ),
        );

        return SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? 16.0 : 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(
                title: 'CSV Export Configuration',
                description: 'Export 9,842 clean customer records with custom delimiters, quote modes, and encoding options.',
                icon: Icons.file_upload_outlined,
              ),
              const SizedBox(height: 20),
              if (isMobile)
                Column(
                  children: [
                    paramsCard,
                    const SizedBox(height: 16),
                    previewCard,
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: paramsCard),
                    const SizedBox(width: 20),
                    Expanded(flex: 2, child: previewCard),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}

/// Screen for Excel Export Configuration
class ExportExcelScreen extends StatelessWidget {
  final ValueChanged<String>? onNavigate;

  const ExportExcelScreen({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;

        return SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? 16.0 : 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(
                title: 'Excel / XLSX Workbook Export',
                description: 'Generate multi-sheet OpenXML workbooks with customized cell formatting, formulas, and styles.',
                icon: Icons.grid_on_rounded,
              ),
              const SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(isMobile ? 16 : 20),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceDark,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppTheme.borderDark),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Workbook Configuration', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                    const SizedBox(height: 16),
                    if (isMobile) ...[
                      _buildTextParam('Primary Sheet Name', 'Active Customers'),
                      const SizedBox(height: 12),
                      _buildDropdownRow('Header Row Theme', 'Dark Navy & Bold White Text', ['Dark Navy & Bold White Text', 'Clean Minimal Gray', 'Emerald Accent', 'Plain Text']),
                    ] else ...[
                      Row(
                        children: [
                          Expanded(child: _buildTextParam('Primary Sheet Name', 'Active Customers')),
                          const SizedBox(width: 16),
                          Expanded(child: _buildDropdownRow('Header Row Theme', 'Dark Navy & Bold White Text', ['Dark Navy & Bold White Text', 'Clean Minimal Gray', 'Emerald Accent', 'Plain Text'])),
                        ],
                      ),
                    ],
                    const SizedBox(height: 16),
                    _buildToggleRow('Freeze Top Header Row', 'Keep column headers visible when scrolling down rows in Excel', true),
                    const SizedBox(height: 10),
                    _buildToggleRow('Auto-Fit Column Widths', 'Calculate cell content widths automatically to prevent text clipping', true),
                    const SizedBox(height: 10),
                    _buildToggleRow('Apply Currency Formatting', 'Render revenue values as localized currency (\$#,##0.00)', true),
                    const SizedBox(height: 20),
                    const Divider(color: AppTheme.borderDark),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      runSpacing: 10,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.table_view_rounded, size: 16),
                          label: const Text('Export Excel Workbook (.xlsx)'),
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF107C41), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14)),
                        ),
                        OutlinedButton(onPressed: () => onNavigate?.call('export_csv'), style: OutlinedButton.styleFrom(foregroundColor: AppTheme.textSecondary, padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14)), child: const Text('Switch to CSV Export')),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextParam(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.textSecondary)),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(color: AppTheme.cardDark, borderRadius: BorderRadius.circular(6), border: Border.all(color: AppTheme.borderDark)),
          child: Text(value, style: const TextStyle(color: AppTheme.textPrimary, fontSize: 13, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}

/// Screen for JSON Export Configuration
class ExportJsonScreen extends StatelessWidget {
  final ValueChanged<String>? onNavigate;

  const ExportJsonScreen({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;

        final structCard = Container(
          padding: EdgeInsets.all(isMobile ? 16 : 20),
          decoration: BoxDecoration(color: AppTheme.surfaceDark, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppTheme.borderDark)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Serialization Structure', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
              const SizedBox(height: 16),
              _buildDropdownRow('Output Format', 'Standard JSON Array ([{...}, {...}])', ['Standard JSON Array ([{...}, {...}])', 'JSON Lines (One object per line)', 'Wrapped Envelope ({"count": N, "data": [...]})']),
              const SizedBox(height: 14),
              _buildDropdownRow('Indentation & Formatting', 'Pretty Print (2 Spaces)', ['Pretty Print (2 Spaces)', 'Minified (Compact single-line)']),
              const SizedBox(height: 14),
              _buildToggleRow('Include Null Fields', 'Explicitly serialize keys with null values instead of omitting them', false),
              const SizedBox(height: 10),
              _buildToggleRow('ISO-8601 Date Serialization', 'Serialize dates into standard UTC ISO strings', true),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download_rounded, size: 16),
                  label: const Text('Export JSON Payload (9,842 items)'),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF16529), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14)),
                ),
              ),
            ],
          ),
        );

        final jsonPreviewCard = Container(
          padding: EdgeInsets.all(isMobile ? 16 : 20),
          decoration: BoxDecoration(color: AppTheme.surfaceDark, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppTheme.borderDark)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('JSON Payload Preview', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(color: AppTheme.cardDark, borderRadius: BorderRadius.circular(6), border: Border.all(color: AppTheme.borderDark)),
                child: const Text(
                  '[\n  {\n    "id": 1001,\n    "name": "Alex Johnson",\n    "email": "alex@example.com",\n    "company": "Demo Corporation",\n    "revenue": 125000.0,\n    "status": "ACTIVE"\n  },\n  {\n    "id": 1002,\n    "name": "Sarah Connor",\n    "email": "sarah@techcorp.io",\n    "company": "TechCorp Solutions",\n    "revenue": 84000.0,\n    "status": "ACTIVE"\n  }\n]',
                  style: TextStyle(fontFamily: 'Courier', fontSize: 11, color: Color(0xFFF16529), height: 1.4),
                ),
              ),
            ],
          ),
        );

        return SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? 16.0 : 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(
                title: 'JSON / JSONL Export Configuration',
                description: 'Serialize datasets to formatted JSON, JSON Lines (JSONL), or custom REST response envelopes.',
                icon: Icons.data_object_rounded,
              ),
              const SizedBox(height: 20),
              if (isMobile)
                Column(
                  children: [
                    structCard,
                    const SizedBox(height: 16),
                    jsonPreviewCard,
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: structCard),
                    const SizedBox(width: 20),
                    Expanded(flex: 2, child: jsonPreviewCard),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}

// Helpers
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

Widget _buildDropdownRow(String label, String value, List<String> options) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.textSecondary)),
      const SizedBox(height: 6),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(color: AppTheme.cardDark, borderRadius: BorderRadius.circular(6), border: Border.all(color: AppTheme.borderDark)),
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
      Switch(value: isChecked, onChanged: (_) {}, activeThumbColor: AppTheme.primaryBlue),
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

Widget _buildFieldCheckChip(String label, bool isChecked) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(color: AppTheme.cardDark, borderRadius: BorderRadius.circular(6), border: Border.all(color: AppTheme.primaryBlue.withValues(alpha: 0.5))),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.check_box_rounded, size: 16, color: AppTheme.primaryBlue),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.textPrimary, fontWeight: FontWeight.w500)),
      ],
    ),
  );
}

Widget _buildInfoTile(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.textMuted)),
        Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
      ],
    ),
  );
}
