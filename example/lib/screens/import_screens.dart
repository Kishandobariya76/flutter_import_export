import 'package:flutter/material.dart';
import 'package:flutter_import_export/flutter_import_export.dart';
import '../data/demo_data.dart';
import '../widgets/app_theme.dart';

/// Screen for CSV Import Configuration
class ImportCsvScreen extends StatelessWidget {
  final ValueChanged<String>? onNavigate;

  const ImportCsvScreen({super.key, this.onNavigate});

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
              const Text(
                'File Ingestion Parameters',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
              ),
              const SizedBox(height: 16),
              _buildFileCard(fileName: 'customers.csv', fileSize: '482.4 KB (10,000 rows)', format: 'Comma-Separated Values', isMobile: isMobile),
              const SizedBox(height: 18),
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
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => onNavigate?.call('file_preview'),
                    icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                    label: const Text('Parse & Preview Dataset'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () => onNavigate?.call('dashboard'),
                    style: OutlinedButton.styleFrom(foregroundColor: AppTheme.textSecondary),
                    child: const Text('Cancel'),
                  ),
                ],
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
                  Icon(Icons.terminal_rounded, size: 18, color: AppTheme.primaryBlue),
                  SizedBox(width: 8),
                  Text('Raw Stream First 5 Lines', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
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
                    fontSize: 11,
                    color: Color(0xFF58A6FF),
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              _buildInfoBanner('Engine will stream in chunks of 250 rows to optimize memory latency on web and mobile.'),
            ],
          ),
        );

        return SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? 16.0 : 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(
                title: 'CSV Import Configuration',
                description: 'Configure delimiter detection, quote characters, text encodings, and row offset for CSV ingestion.',
                icon: Icons.format_align_left_rounded,
                isMobile: isMobile,
              ),
              const SizedBox(height: 18),
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

/// Screen for Excel Import Configuration
class ImportExcelScreen extends StatelessWidget {
  final ValueChanged<String>? onNavigate;

  const ImportExcelScreen({super.key, this.onNavigate});

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
                title: 'Excel / Spreadsheet Import',
                description: 'Read multi-sheet XLSX and XLS workbooks, evaluate formulas, and inspect table structure.',
                icon: Icons.grid_on_rounded,
                isMobile: isMobile,
              ),
              const SizedBox(height: 18),
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
                    _buildFileCard(fileName: 'customers.xlsx', fileSize: '814.2 KB (10,000 rows across 3 sheets)', format: 'Microsoft Excel OpenXML (.xlsx)', isMobile: isMobile),
                    const SizedBox(height: 18),
                    const Text('Detected Worksheets', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                    const SizedBox(height: 12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildSheetCard('Customers (Active)', '10,000 rows • 6 cols', true),
                          const SizedBox(width: 12),
                          _buildSheetCard('Archived Accounts', '2,450 rows • 6 cols', false),
                          const SizedBox(width: 12),
                          _buildSheetCard('Schema_Metadata', '18 rows • 3 cols', false),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(color: AppTheme.borderDark),
                    const SizedBox(height: 16),
                    if (isMobile)
                      Column(
                        children: [
                          _buildDropdownRow('Header Row Index', 'Row 1 (Top Header)', ['Row 1 (Top Header)', 'Row 2', 'Row 3']),
                          const SizedBox(height: 14),
                          _buildDropdownRow('Date Format Handling', 'ISO-8601 (YYYY-MM-DD)', ['ISO-8601 (YYYY-MM-DD)', 'Excel Serial Number', 'US (MM/DD/YYYY)']),
                        ],
                      )
                    else
                      Row(
                        children: [
                          Expanded(child: _buildDropdownRow('Header Row Index', 'Row 1 (Top Header)', ['Row 1 (Top Header)', 'Row 2', 'Row 3'])),
                          const SizedBox(width: 20),
                          Expanded(child: _buildDropdownRow('Date Format Handling', 'ISO-8601 (YYYY-MM-DD)', ['ISO-8601 (YYYY-MM-DD)', 'Excel Serial Number', 'US (MM/DD/YYYY)'])),
                        ],
                      ),
                    const SizedBox(height: 14),
                    _buildToggleRow('Evaluate Formulas to Computed Values', 'Extract calculated cell results instead of raw formulas', true),
                    const SizedBox(height: 8),
                    _buildToggleRow('Ignore Hidden Rows & Filtered Out Rows', 'Do not ingest rows marked as hidden in Excel view', true),
                    const SizedBox(height: 22),
                    ElevatedButton.icon(
                      onPressed: () => onNavigate?.call('file_preview'),
                      icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                      label: const Text('Inspect Sheet & Preview Data'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF107C41),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
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

  Widget _buildSheetCard(String name, String details, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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
          Icon(Icons.table_chart_outlined, size: 18, color: isSelected ? const Color(0xFF3FB950) : AppTheme.textMuted),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: isSelected ? Colors.white : AppTheme.textPrimary)),
              Text(details, style: const TextStyle(fontSize: 10, color: AppTheme.textMuted)),
            ],
          ),
          if (isSelected) ...[
            const SizedBox(width: 8),
            const Icon(Icons.check_circle, size: 14, color: Color(0xFF3FB950)),
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;

        return SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? 16.0 : 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(
                title: 'JSON / JSONL Import Configuration',
                description: 'Extract datasets from JSON arrays or newline-delimited JSON with JSONPath traversal and flattening.',
                icon: Icons.data_object_rounded,
                isMobile: isMobile,
              ),
              const SizedBox(height: 18),
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
                    _buildFileCard(fileName: 'customers.json', fileSize: '1.24 MB (10,000 objects)', format: 'JSON Structured Object Envelope', isMobile: isMobile),
                    const SizedBox(height: 18),
                    _buildDropdownRow('Root JSONPath Array Selector', r'$.data.customers[*]', [r'$.data.customers[*]', r'$[*]', r'$.items[*]']),
                    const SizedBox(height: 14),
                    _buildToggleRow('Flatten Nested Objects', 'Convert nested objects like {"company": {"name": "..."}} to company_name', true),
                    const SizedBox(height: 8),
                    _buildToggleRow('Convert Arrays to Delimited Strings', 'Join primitive arrays like ["tag1", "tag2"] into "tag1, tag2"', true),
                    const SizedBox(height: 18),
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
                        style: TextStyle(fontFamily: 'Courier', fontSize: 11, color: Color(0xFFF16529), height: 1.4),
                      ),
                    ),
                    const SizedBox(height: 22),
                    ElevatedButton.icon(
                      onPressed: () => onNavigate?.call('file_preview'),
                      icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                      label: const Text('Parse JSON & Preview Table'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF16529),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
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
}

/// Screen for File Data Preview
class FilePreviewScreen extends StatefulWidget {
  final ValueChanged<String>? onNavigate;

  const FilePreviewScreen({super.key, this.onNavigate});

  @override
  State<FilePreviewScreen> createState() => _FilePreviewScreenState();
}

class _FilePreviewScreenState extends State<FilePreviewScreen> {
  String _selectedPreset = 'dark';
  Color _borderColor = const Color(0xFF388BFD);
  double _borderWidth = 1.5;
  double _borderRadius = 10.0;
  bool _enableZebra = true;
  bool _showVerticalLines = false;
  bool _showHorizontalLines = true;

  TableDesignConfig get _currentDesign {
    TableDesignConfig base;
    switch (_selectedPreset) {
      case 'light':
        base = TableDesignConfig.light();
        break;
      case 'ocean':
        base = TableDesignConfig.oceanNavy();
        break;
      case 'emerald':
        base = TableDesignConfig.emerald();
        break;
      case 'minimal':
        base = TableDesignConfig.minimalBordered(borderColor: _borderColor);
        break;
      case 'dark':
      default:
        base = TableDesignConfig.dark();
        break;
    }

    return base.copyWith(
      borderColor: _borderColor,
      borderWidth: _borderWidth,
      borderRadius: BorderRadius.circular(_borderRadius),
      alternateRowBackgroundColor: _enableZebra
          ? (_selectedPreset == 'light' ? const Color(0xFFF6F8FA) : const Color(0xFF13171F))
          : null,
      showVerticalGridLines: _showVerticalLines,
      showHorizontalGridLines: _showHorizontalLines,
      gridLineColor: _borderColor.withValues(alpha: 0.25),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;
        final design = _currentDesign;

        return SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? 16.0 : 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 12,
                runSpacing: 10,
                children: [
                  _buildHeader(
                    title: 'Data Preview & Table Designer',
                    description: 'Customize table design, borders, header styling, and alternating colors in real-time.',
                    icon: Icons.table_chart_rounded,
                    isMobile: isMobile,
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () => widget.onNavigate?.call('import_csv'),
                        icon: const Icon(Icons.arrow_back, size: 14),
                        label: const Text('Setup'),
                        style: OutlinedButton.styleFrom(foregroundColor: AppTheme.textSecondary),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => widget.onNavigate?.call('column_mapping'),
                        icon: const Icon(Icons.schema_rounded, size: 14),
                        label: const Text('Column Mapping'),
                        style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryAccent, foregroundColor: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 18),
              // Table Design Customizer Card
              Container(
                padding: EdgeInsets.all(isMobile ? 14 : 18),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceDark,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _borderColor.withValues(alpha: 0.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.palette_rounded, size: 18, color: _borderColor),
                        const SizedBox(width: 8),
                        const Text(
                          'Live Table Design Controls (TableDesignConfig)',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    // Theme Presets
                    const Text('Theme Presets:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.textMuted)),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildPresetChip('Modern Dark', 'dark'),
                        _buildPresetChip('Clean Light', 'light'),
                        _buildPresetChip('Ocean Navy', 'ocean'),
                        _buildPresetChip('Emerald Fintech', 'emerald'),
                        _buildPresetChip('Minimal Outline', 'minimal'),
                      ],
                    ),
                    const SizedBox(height: 14),
                    const Divider(color: AppTheme.borderDark),
                    const SizedBox(height: 10),
                    // Border Colors & Properties
                    Wrap(
                      spacing: 20,
                      runSpacing: 12,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        // Border Color Choices
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Border Color: ', style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                            const SizedBox(width: 6),
                            _buildColorDot(const Color(0xFF388BFD), 'Blue'),
                            _buildColorDot(const Color(0xFF238636), 'Green'),
                            _buildColorDot(const Color(0xFFA371F7), 'Purple'),
                            _buildColorDot(const Color(0xFFD29922), 'Amber'),
                            _buildColorDot(const Color(0xFFF85149), 'Red'),
                            _buildColorDot(const Color(0xFF30363D), 'Dark'),
                          ],
                        ),
                        // Border Width Choice
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Border: ', style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                            _buildOptionButton('1px', _borderWidth == 1.0, () => setState(() => _borderWidth = 1.0)),
                            _buildOptionButton('2px', _borderWidth == 2.0, () => setState(() => _borderWidth = 2.0)),
                            _buildOptionButton('3px', _borderWidth == 3.0, () => setState(() => _borderWidth = 3.0)),
                          ],
                        ),
                        // Border Radius Choice
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Radius: ', style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                            _buildOptionButton('0px', _borderRadius == 0.0, () => setState(() => _borderRadius = 0.0)),
                            _buildOptionButton('8px', _borderRadius == 8.0, () => setState(() => _borderRadius = 8.0)),
                            _buildOptionButton('12px', _borderRadius == 12.0, () => setState(() => _borderRadius = 12.0)),
                            _buildOptionButton('20px', _borderRadius == 20.0, () => setState(() => _borderRadius = 20.0)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 16,
                      runSpacing: 8,
                      children: [
                        _buildToggleSwitch('Alternating Rows (Zebra)', _enableZebra, (val) => setState(() => _enableZebra = val)),
                        _buildToggleSwitch('Vertical Gridlines', _showVerticalLines, (val) => setState(() => _showVerticalLines = val)),
                        _buildToggleSwitch('Horizontal Gridlines', _showHorizontalLines, (val) => setState(() => _showHorizontalLines = val)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              // Package's ImportExportDataTable Component
              ImportExportDataTable(
                columns: const [
                  TableColumnDef(key: 'id', title: 'id', subTitle: 'INTEGER'),
                  TableColumnDef(key: 'name', title: 'name', subTitle: 'STRING'),
                  TableColumnDef(key: 'email', title: 'email', subTitle: 'EMAIL'),
                  TableColumnDef(key: 'company', title: 'company', subTitle: 'STRING'),
                  TableColumnDef(key: 'revenue', title: 'revenue', subTitle: 'DECIMAL'),
                  TableColumnDef(key: 'status', title: 'status', subTitle: 'ENUM'),
                ],
                rows: DemoData.sampleRows,
                designConfig: design,
                pageSize: 8,
                cellBuilder: (context, index, columnKey, value) {
                  if (columnKey == 'revenue' && value is num) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '\$${value.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: design.cellTextStyle?.color ?? const Color(0xFFC9D1D9),
                          fontFamily: 'Courier',
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    );
                  }
                  if (columnKey == 'status' && value is String) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: _buildStatusBadge(value),
                    );
                  }
                  return null; // Fallback to standard renderer
                },
              ),
              const SizedBox(height: 18),
              // Live Code Implementation Box
              Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppTheme.cardDark,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.borderDark),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.code_rounded, size: 16, color: AppTheme.primaryBlue),
                        SizedBox(width: 8),
                        Text('Copyable Code Implementation:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppTheme.textPrimary)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'ImportExportDataTable(\n'
                      '  columns: const [\n'
                      '    TableColumnDef(key: "id", title: "id", subTitle: "INTEGER"),\n'
                      '    TableColumnDef(key: "name", title: "name", subTitle: "STRING"),\n'
                      '    TableColumnDef(key: "email", title: "email", subTitle: "EMAIL"),\n'
                      '  ],\n'
                      '  rows: datasetRows,\n'
                      '  designConfig: TableDesignConfig(\n'
                      '    borderColor: Color(0x${_borderColor.toARGB32().toRadixString(16).toUpperCase()}),\n'
                      '    borderWidth: $_borderWidth,\n'
                      '    borderRadius: BorderRadius.circular($_borderRadius),\n'
                      '    showVerticalGridLines: $_showVerticalLines,\n'
                      '    showHorizontalGridLines: $_showHorizontalLines,\n'
                      '  ),\n'
                      ')',
                      style: const TextStyle(fontFamily: 'Courier', fontSize: 11, color: Color(0xFF58A6FF), height: 1.4),
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

  Widget _buildPresetChip(String label, String key) {
    final isSelected = _selectedPreset == key;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: AppTheme.primaryBlue.withValues(alpha: 0.25),
      backgroundColor: AppTheme.cardDark,
      labelStyle: TextStyle(
        fontSize: 11,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        color: isSelected ? AppTheme.primaryBlue : AppTheme.textSecondary,
      ),
      side: BorderSide(
        color: isSelected ? AppTheme.primaryBlue : AppTheme.borderDark,
      ),
      onSelected: (_) {
        setState(() {
          _selectedPreset = key;
          if (key == 'ocean') _borderColor = const Color(0xFF1E3A66);
          if (key == 'emerald') _borderColor = const Color(0xFF238636);
          if (key == 'light') _borderColor = const Color(0xFFD0D7DE);
          if (key == 'dark') _borderColor = const Color(0xFF388BFD);
          if (key == 'minimal') _borderColor = const Color(0xFFA371F7);
        });
      },
    );
  }

  Widget _buildColorDot(Color color, String tooltip) {
    final isSelected = _borderColor.toARGB32() == color.toARGB32();
    return GestureDetector(
      onTap: () => setState(() => _borderColor = color),
      child: Tooltip(
        message: tooltip,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? Colors.white : Colors.transparent,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 4),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryBlue : AppTheme.cardDark,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: isSelected ? AppTheme.primaryBlue : AppTheme.borderDark),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.white : AppTheme.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildToggleSwitch(String label, bool value, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 28,
          child: Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppTheme.primaryBlue,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
      ],
    );
  }

  Widget _buildStatusBadge(String status) {
    final isPending = status == 'PENDING';
    final isInactive = status == 'INACTIVE';
    final color = isPending ? AppTheme.warningAmber : (isInactive ? AppTheme.errorRed : AppTheme.successGreen);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        status,
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// Shared UI Helpers
Widget _buildHeader({required String title, required String description, required IconData icon, bool isMobile = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(icon, color: AppTheme.primaryBlue, size: isMobile ? 20 : 24),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: isMobile ? 17 : 20, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
            ),
          ),
        ],
      ),
      const SizedBox(height: 4),
      Text(description, style: TextStyle(fontSize: isMobile ? 11 : 13, color: AppTheme.textSecondary)),
    ],
  );
}

Widget _buildFileCard({required String fileName, required String fileSize, required String format, bool isMobile = false}) {
  return Container(
    padding: EdgeInsets.all(isMobile ? 10 : 14),
    decoration: BoxDecoration(
      color: AppTheme.cardDark,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: AppTheme.borderDark),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryAccent.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Icon(Icons.insert_drive_file_outlined, color: AppTheme.primaryBlue, size: 20),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(fileName, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppTheme.textPrimary)),
              const SizedBox(height: 2),
              Text('$fileSize • $format', overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11, color: AppTheme.textMuted)),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            color: AppTheme.successGreen.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text('READY', style: TextStyle(color: AppTheme.successGreen, fontSize: 10, fontWeight: FontWeight.bold)),
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
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
            style: const TextStyle(color: AppTheme.textPrimary, fontSize: 12),
            items: options.map((opt) => DropdownMenuItem(value: opt, child: Text(opt, overflow: TextOverflow.ellipsis))).toList(),
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
      const SizedBox(width: 8),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.textPrimary)),
            Text(subtitle, style: const TextStyle(fontSize: 10, color: AppTheme.textMuted)),
          ],
        ),
      ),
    ],
  );
}

Widget _buildInfoBanner(String text) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: AppTheme.primaryAccent.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: AppTheme.primaryBlue.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        const Icon(Icons.info_outline, size: 14, color: AppTheme.primaryBlue),
        const SizedBox(width: 6),
        Expanded(child: Text(text, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 11))),
      ],
    ),
  );
}
