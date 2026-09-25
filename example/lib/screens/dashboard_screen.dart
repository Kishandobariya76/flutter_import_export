import 'package:flutter/material.dart';
import '../data/demo_data.dart';
import '../widgets/app_theme.dart';

class DashboardScreen extends StatelessWidget {
  final ValueChanged<String>? onNavigate;

  const DashboardScreen({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Banner
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryAccent.withValues(alpha: 0.15),
                  AppTheme.surfaceDark,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.borderDark),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.auto_awesome, color: AppTheme.primaryBlue, size: 22),
                          SizedBox(width: 8),
                          Text(
                            'Production Data Import & Export Toolkit',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textPrimary,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Import, validate, transform, and export massive CSV, Excel, and JSON datasets with high performance, schema mapping, and real-time isolate streaming.',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.textSecondary,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 12,
                        runSpacing: 8,
                        children: [
                          _buildActionChip(
                            label: 'New Import Job',
                            icon: Icons.upload_file_rounded,
                            isPrimary: true,
                            onTap: () => onNavigate?.call('import_csv'),
                          ),
                          _buildActionChip(
                            label: 'Export Records',
                            icon: Icons.download_rounded,
                            onTap: () => onNavigate?.call('export_csv'),
                          ),
                          _buildActionChip(
                            label: 'Configuration Playground',
                            icon: Icons.tune_rounded,
                            onTap: () => onNavigate?.call('configuration_playground'),
                          ),
                          _buildActionChip(
                            label: 'Developer Mode',
                            icon: Icons.developer_mode_rounded,
                            onTap: () => onNavigate?.call('developer_mode'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // KPI Metrics Grid
          Row(
            children: [
              Expanded(
                child: _buildKpiCard(
                  title: 'Total Imports',
                  value: '${DemoData.totalImports}',
                  subtitle: '+14% from last period',
                  icon: Icons.file_download_done_rounded,
                  color: AppTheme.primaryBlue,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildKpiCard(
                  title: 'Total Exports',
                  value: '${DemoData.totalExports}',
                  subtitle: 'CSV, Excel & JSON formats',
                  icon: Icons.file_upload_outlined,
                  color: AppTheme.successGreen,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildKpiCard(
                  title: 'Resolved Errors',
                  value: '${DemoData.totalErrors}',
                  subtitle: '0.12% error rate handled',
                  icon: Icons.warning_amber_rounded,
                  color: AppTheme.warningAmber,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildKpiCard(
                  title: 'Peak Throughput',
                  value: '8,540',
                  unit: 'rows/s',
                  subtitle: 'Multi-isolate parallel parsing',
                  icon: Icons.bolt_rounded,
                  color: const Color(0xFFA371F7),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Two-column layout: Recent Import & Supported Formats
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Recent Import Card
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceDark,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.borderDark),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.history_rounded, color: AppTheme.primaryBlue, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Recent Import Activity',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.successGreen.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'SUCCESS',
                              style: TextStyle(
                                color: AppTheme.successGreen,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme.cardDark,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppTheme.borderDark),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF107C41).withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(Icons.table_chart_rounded, color: Color(0xFF107C41), size: 28),
                                ),
                                const SizedBox(width: 14),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        DemoData.recentFileName,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.textPrimary,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '10,000 rows • 9,842 successful • 112 warnings • 46 errors',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: AppTheme.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text(
                                      'Duration',
                                      style: TextStyle(color: AppTheme.textMuted, fontSize: 11),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      DemoData.recentDuration,
                                      style: const TextStyle(
                                        color: AppTheme.textPrimary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // Progress visualization
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 9842,
                                    child: Container(height: 8, color: AppTheme.successGreen),
                                  ),
                                  Expanded(
                                    flex: 112,
                                    child: Container(height: 8, color: AppTheme.warningAmber),
                                  ),
                                  Expanded(
                                    flex: 46,
                                    child: Container(height: 8, color: AppTheme.errorRed),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 12,
                              runSpacing: 6,
                              children: [
                                _buildLegendItem('Successful: 9,842 (98.4%)', AppTheme.successGreen),
                                _buildLegendItem('Warnings: 112 (1.1%)', AppTheme.warningAmber),
                                _buildLegendItem('Errors: 46 (0.5%)', AppTheme.errorRed),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 12,
                        runSpacing: 8,
                        children: [
                          OutlinedButton.icon(
                            onPressed: () => onNavigate?.call('import_result'),
                            icon: const Icon(Icons.assessment_outlined, size: 16),
                            label: const Text('View Full Import Summary'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppTheme.primaryBlue,
                              side: const BorderSide(color: AppTheme.borderDark),
                            ),
                          ),
                          OutlinedButton.icon(
                            onPressed: () => onNavigate?.call('validation'),
                            icon: const Icon(Icons.bug_report_outlined, size: 16),
                            label: const Text('Inspect Validation Issues (46)'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppTheme.warningAmber,
                              side: const BorderSide(color: AppTheme.borderDark),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Supported Format Cards
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceDark,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.borderDark),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Data Format Capabilities',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildFormatTile(
                        title: 'CSV Format',
                        subtitle: 'Comma, semicolon, tab, custom quotes',
                        icon: Icons.format_align_left_rounded,
                        color: Colors.blueAccent,
                        badge: 'Auto-Sniffer',
                        onTap: () => onNavigate?.call('import_csv'),
                      ),
                      const SizedBox(height: 10),
                      _buildFormatTile(
                        title: 'Excel (XLSX)',
                        subtitle: 'Multi-sheet, formulas, styled workbooks',
                        icon: Icons.grid_on_rounded,
                        color: const Color(0xFF107C41),
                        badge: 'Worksheets',
                        onTap: () => onNavigate?.call('import_excel'),
                      ),
                      const SizedBox(height: 10),
                      _buildFormatTile(
                        title: 'JSON & JSONL',
                        subtitle: 'Path queries, arrays, nested flattening',
                        icon: Icons.data_object_rounded,
                        color: const Color(0xFFF16529),
                        badge: 'Path Traversal',
                        onTap: () => onNavigate?.call('import_json'),
                      ),
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

  static Widget _buildKpiCard({
    required String title,
    required String value,
    String? unit,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.borderDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textSecondary,
                ),
              ),
              Icon(icon, color: color, size: 20),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                  letterSpacing: -1.0,
                ),
              ),
              if (unit != null) ...[
                const SizedBox(width: 4),
                Text(
                  unit,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildActionChip({
    required String label,
    required IconData icon,
    bool isPrimary = false,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isPrimary ? AppTheme.primaryAccent : AppTheme.cardDark,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isPrimary ? AppTheme.primaryBlue : AppTheme.borderDark,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: isPrimary ? Colors.white : AppTheme.primaryBlue),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isPrimary ? Colors.white : AppTheme.textPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildFormatTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required String badge,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
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
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceDark,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: AppTheme.borderDark),
                        ),
                        child: Text(
                          badge,
                          style: const TextStyle(color: AppTheme.textMuted, fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: AppTheme.textMuted),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppTheme.textMuted, size: 18),
          ],
        ),
      ),
    );
  }

  static Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
      ],
    );
  }
}
