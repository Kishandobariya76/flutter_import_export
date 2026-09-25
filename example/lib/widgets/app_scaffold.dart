import 'package:flutter/material.dart';
import 'app_theme.dart';

const List<Map<String, String>> kScreenRegistry = [
  {'id': 'dashboard', 'title': 'Dashboard', 'category': 'Overview'},
  {'id': 'import_csv', 'title': 'CSV Import Configuration', 'category': 'Import'},
  {'id': 'import_excel', 'title': 'Excel / Spreadsheet Import', 'category': 'Import'},
  {'id': 'import_json', 'title': 'JSON / JSONL Import', 'category': 'Import'},
  {'id': 'file_preview', 'title': 'File Data Preview', 'category': 'Workflow'},
  {'id': 'column_mapping', 'title': 'Column Mapping', 'category': 'Workflow'},
  {'id': 'smart_mapping', 'title': 'Smart Matching Engine', 'category': 'Workflow'},
  {'id': 'validation', 'title': 'Data Validation Report', 'category': 'Validation'},
  {'id': 'duplicate_detection', 'title': 'Duplicate Detection', 'category': 'Validation'},
  {'id': 'transformation', 'title': 'Transformation Pipeline', 'category': 'Workflow'},
  {'id': 'import_result', 'title': 'Import Execution Summary', 'category': 'Workflow'},
  {'id': 'export_csv', 'title': 'CSV Export Settings', 'category': 'Export'},
  {'id': 'export_excel', 'title': 'Excel Export Settings', 'category': 'Export'},
  {'id': 'export_json', 'title': 'JSON Export Settings', 'category': 'Export'},
  {'id': 'large_file_processing', 'title': 'Streaming & Chunking Monitor', 'category': 'Streaming'},
  {'id': 'cancellation', 'title': 'Cancellation & Rollback', 'category': 'Streaming'},
  {'id': 'configuration_playground', 'title': 'Configuration Playground', 'category': 'Developer'},
  {'id': 'developer_mode', 'title': 'Developer Mode & State', 'category': 'Developer'},
  {'id': 'import_inspector', 'title': 'Import Session Inspector', 'category': 'Developer'},
  {'id': 'schema_inspector', 'title': 'Schema Definition Inspector', 'category': 'Developer'},
  {'id': 'diagnostics', 'title': 'System Diagnostics', 'category': 'Developer'},
  {'id': 'logs', 'title': 'Structured Event Logs', 'category': 'Developer'},
  {'id': 'error_details', 'title': 'Error Inspection Drawer', 'category': 'Validation'},
  {'id': 'performance', 'title': 'Performance Benchmarks', 'category': 'Developer'},
];

class AppScaffold extends StatelessWidget {
  final String currentScreenId;
  final Widget child;
  final ValueChanged<String>? onNavigate;

  const AppScaffold({
    super.key,
    required this.currentScreenId,
    required this.child,
    this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final currentInfo = kScreenRegistry.firstWhere(
      (s) => s['id'] == currentScreenId,
      orElse: () => kScreenRegistry.first,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;

        return Scaffold(
          backgroundColor: AppTheme.bgDark,
          body: SafeArea(
            child: Column(
              children: [
                // Top Navigation Header
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 16 : 24,
                    vertical: isMobile ? 10 : 14,
                  ),
                  decoration: const BoxDecoration(
                    color: AppTheme.surfaceDark,
                    border: Border(
                      bottom: BorderSide(color: AppTheme.borderDark, width: 1),
                    ),
                  ),
                  child: isMobile
                      ? _buildMobileHeader(context, currentInfo)
                      : _buildDesktopHeader(context, currentInfo),
                ),
                // Subheader with active screen details
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 16 : 24,
                    vertical: 8,
                  ),
                  decoration: const BoxDecoration(
                    color: AppTheme.bgDark,
                    border: Border(
                      bottom: BorderSide(color: AppTheme.borderDark, width: 0.5),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.folder_open_rounded, size: 14, color: AppTheme.primaryBlue.withValues(alpha: 0.8)),
                      const SizedBox(width: 6),
                      Text(
                        '${currentInfo['category']} / ',
                        style: const TextStyle(color: AppTheme.textMuted, fontSize: 11),
                      ),
                      Flexible(
                        child: Text(
                          currentInfo['title'] ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppTheme.textPrimary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (!isMobile) ...[
                        const Spacer(),
                        const Text(
                          'Multi-Platform Core • Android, iOS, Web & Desktop',
                          style: TextStyle(color: AppTheme.textMuted, fontSize: 11),
                        ),
                      ],
                    ],
                  ),
                ),
                // Screen Content
                Expanded(
                  child: child,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDesktopHeader(BuildContext context, Map<String, String> currentInfo) {
    return Row(
      children: [
        // Brand / Title
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.primaryAccent.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppTheme.primaryBlue.withValues(alpha: 0.4)),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.swap_horiz_rounded, color: AppTheme.primaryBlue, size: 20),
              SizedBox(width: 8),
              Text(
                'Flutter Import Export',
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppTheme.cardDark,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppTheme.borderDark),
          ),
          child: const Text(
            'v1.0.0 • PRO',
            style: TextStyle(
              color: AppTheme.textMuted,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppTheme.successGreen.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.successGreen.withValues(alpha: 0.4)),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.circle, size: 8, color: AppTheme.successGreen),
              SizedBox(width: 6),
              Text(
                'DEMO DATASET LOCKED',
                style: TextStyle(
                  color: AppTheme.successGreen,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        // Screen selector dropdown
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: AppTheme.cardDark,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppTheme.borderDark),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: currentScreenId,
              dropdownColor: AppTheme.surfaceDark,
              icon: const Icon(Icons.arrow_drop_down, color: AppTheme.textSecondary),
              style: const TextStyle(color: AppTheme.textPrimary, fontSize: 13, fontWeight: FontWeight.w500),
              items: kScreenRegistry.map((screen) {
                return DropdownMenuItem<String>(
                  value: screen['id'],
                  child: Text('${screen['category']}: ${screen['title']}'),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null && onNavigate != null) {
                  onNavigate!(val);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileHeader(BuildContext context, Map<String, String> currentInfo) {
    return Row(
      children: [
        // Brand logo & title
        const Icon(Icons.swap_horiz_rounded, color: AppTheme.primaryBlue, size: 22),
        const SizedBox(width: 8),
        const Expanded(
          child: Text(
            'Import Export Studio',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(width: 8),
        // Compact Screen Selector for Mobile
        PopupMenuButton<String>(
          tooltip: 'Select Screen',
          color: AppTheme.surfaceDark,
          icon: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.cardDark,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppTheme.borderDark),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.dashboard_customize_rounded, color: AppTheme.primaryBlue, size: 16),
                SizedBox(width: 6),
                Text('Screens', style: TextStyle(color: AppTheme.textPrimary, fontSize: 12, fontWeight: FontWeight.w600)),
                Icon(Icons.arrow_drop_down, color: AppTheme.textSecondary, size: 16),
              ],
            ),
          ),
          onSelected: (val) {
            if (onNavigate != null) {
              onNavigate!(val);
            }
          },
          itemBuilder: (ctx) {
            return kScreenRegistry.map((screen) {
              final isCurrent = screen['id'] == currentScreenId;
              return PopupMenuItem<String>(
                value: screen['id'],
                child: Row(
                  children: [
                    Icon(
                      isCurrent ? Icons.check_circle_rounded : Icons.circle_outlined,
                      size: 14,
                      color: isCurrent ? AppTheme.primaryBlue : AppTheme.textMuted,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${screen['category']}: ${screen['title']}',
                        style: TextStyle(
                          fontSize: 12,
                          color: isCurrent ? AppTheme.primaryBlue : AppTheme.textPrimary,
                          fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList();
          },
        ),
      ],
    );
  }
}
