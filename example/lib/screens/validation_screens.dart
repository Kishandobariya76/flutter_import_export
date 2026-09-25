import 'package:flutter/material.dart';
import '../widgets/app_theme.dart';

/// Screen for Data Validation Report
class ValidationScreen extends StatelessWidget {
  final ValueChanged<String>? onNavigate;

  const ValidationScreen({super.key, this.onNavigate});

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
                title: 'Validation Results: 10,000 Records Checked',
                description: 'Pre-persistence schema validation. 9,842 rows passed, 112 warnings, 46 errors detected.',
                icon: Icons.verified_user_rounded,
              ),
              Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: () => onNavigate?.call('duplicate_detection'),
                    icon: const Icon(Icons.copy_rounded, size: 16),
                    label: const Text('Duplicate Detection (18 pairs)'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.warningAmber,
                      side: const BorderSide(color: AppTheme.borderDark),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () => onNavigate?.call('import_result'),
                    icon: const Icon(Icons.play_arrow_rounded, size: 16),
                    label: const Text('Execute Import (Commit Valid Rows)'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.successGreen,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Metric Summary Cards
          Row(
            children: [
              _buildMetricCard('Total Validated', '10,000', '100% of dataset', Icons.fact_check_rounded, AppTheme.primaryBlue),
              const SizedBox(width: 14),
              _buildMetricCard('Ready to Persist', '9,842', '98.42% clean records', Icons.check_circle_rounded, AppTheme.successGreen),
              const SizedBox(width: 14),
              _buildMetricCard('Warnings Handled', '112', 'Non-fatal type coercions', Icons.warning_rounded, AppTheme.warningAmber),
              const SizedBox(width: 14),
              _buildMetricCard('Blocking Errors', '46', 'Rows will be skipped/quarantined', Icons.error_rounded, AppTheme.errorRed),
            ],
          ),
          const SizedBox(height: 20),
          // Issue Filter Tabs
          Row(
            children: [
              _buildFilterPill('All Issues (158)', true),
              const SizedBox(width: 8),
              _buildFilterPill('Errors Only (46)', false, color: AppTheme.errorRed),
              const SizedBox(width: 8),
              _buildFilterPill('Warnings Only (112)', false, color: AppTheme.warningAmber),
              const Spacer(),
              OutlinedButton.icon(
                onPressed: () => onNavigate?.call('error_details'),
                icon: const Icon(Icons.bug_report_rounded, size: 14),
                label: const Text('Inspect First Error Details', style: TextStyle(fontSize: 12)),
                style: OutlinedButton.styleFrom(foregroundColor: AppTheme.errorRed, side: const BorderSide(color: AppTheme.borderDark)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Issues Table
          Container(
            decoration: BoxDecoration(
              color: AppTheme.surfaceDark,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.borderDark),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(AppTheme.cardDark),
                columnSpacing: 24,
                headingTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textPrimary, fontSize: 12),
                dataTextStyle: const TextStyle(color: AppTheme.textSecondary, fontSize: 13),
                columns: const [
                  DataColumn(label: Text('SEVERITY')),
                  DataColumn(label: Text('ROW #')),
                  DataColumn(label: Text('FIELD / COLUMN')),
                  DataColumn(label: Text('OFFENDING RAW VALUE')),
                  DataColumn(label: Text('VIOLATED RULE')),
                  DataColumn(label: Text('ERROR MESSAGE & REMEDIATION')),
                ],
                rows: [
                  _buildIssueRow(
                    severity: 'ERROR',
                    rowNum: 47,
                    field: 'email',
                    rawValue: 'alex.invalid-email',
                    rule: 'ValidationRule.email',
                    message: 'Value is not a valid email syntax. Missing "@" or domain.',
                    color: AppTheme.errorRed,
                  ),
                  _buildIssueRow(
                    severity: 'ERROR',
                    rowNum: 89,
                    field: 'name',
                    rawValue: '[EMPTY STRING]',
                    rule: 'ValidationRule.required',
                    message: 'Required field Customer Name cannot be empty or null.',
                    color: AppTheme.errorRed,
                  ),
                  _buildIssueRow(
                    severity: 'WARNING',
                    rowNum: 142,
                    field: 'revenue',
                    rawValue: '-\$1,200.00',
                    rule: 'ValidationRule.range(0, ...)',
                    message: 'Negative revenue detected. Coerced to absolute or quarantined.',
                    color: AppTheme.warningAmber,
                  ),
                  _buildIssueRow(
                    severity: 'WARNING',
                    rowNum: 204,
                    field: 'status',
                    rawValue: 'pending_review',
                    rule: 'ValidationRule.enumType',
                    message: 'Value coerced to PENDING based on nearest enum match.',
                    color: AppTheme.warningAmber,
                  ),
                  _buildIssueRow(
                    severity: 'ERROR',
                    rowNum: 312,
                    field: 'email',
                    rawValue: 'connor@@techcorp.io',
                    rule: 'ValidationRule.email',
                    message: 'Duplicate "@" symbol detected in email string.',
                    color: AppTheme.errorRed,
                  ),
                  _buildIssueRow(
                    severity: 'ERROR',
                    rowNum: 450,
                    field: 'id',
                    rawValue: 'CUST-ALPHA-01',
                    rule: 'ValidationRule.integer',
                    message: 'Cannot parse string to integer identifier.',
                    color: AppTheme.errorRed,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static DataRow _buildIssueRow({
    required String severity,
    required int rowNum,
    required String field,
    required String rawValue,
    required String rule,
    required String message,
    required Color color,
  }) {
    return DataRow(
      cells: [
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(4)),
            child: Text(severity, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
        ),
        DataCell(Text('Row $rowNum', style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textPrimary))),
        DataCell(Text(field, style: const TextStyle(fontFamily: 'Courier', color: AppTheme.primaryBlue))),
        DataCell(Text(rawValue, style: TextStyle(fontFamily: 'Courier', color: color))),
        DataCell(Text(rule, style: const TextStyle(fontSize: 11, color: AppTheme.textMuted))),
        DataCell(Text(message, style: const TextStyle(fontSize: 12))),
      ],
    );
  }

  static Widget _buildMetricCard(String title, String value, String sub, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceDark,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppTheme.borderDark),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontSize: 12, color: AppTheme.textMuted)),
                Icon(icon, color: color, size: 18),
              ],
            ),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
            const SizedBox(height: 2),
            Text(sub, style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
          ],
        ),
      ),
    );
  }

  static Widget _buildFilterPill(String label, bool isSelected, {Color? color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? AppTheme.primaryAccent : AppTheme.cardDark,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: isSelected ? AppTheme.primaryBlue : AppTheme.borderDark),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : (color ?? AppTheme.textSecondary),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// Screen for Duplicate Detection
class DuplicateDetectionScreen extends StatelessWidget {
  final ValueChanged<String>? onNavigate;

  const DuplicateDetectionScreen({super.key, this.onNavigate});

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
                title: 'Duplicate Detection & Conflict Resolution',
                description: 'Unique key analysis on [email, company]. 18 duplicate pairs detected across 10,000 records.',
                icon: Icons.copy_all_rounded,
              ),
              ElevatedButton.icon(
                onPressed: () => onNavigate?.call('import_result'),
                icon: const Icon(Icons.check_rounded, size: 16),
                label: const Text('Confirm Resolution & Execute'),
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.successGreen, foregroundColor: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Strategy Selector Card
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
                const Text('Duplicate Resolution Strategy', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildStrategyOption('Skip Duplicates', 'Preserve first occurrence, drop subsequent rows', true),
                    const SizedBox(width: 12),
                    _buildStrategyOption('Overwrite (Upsert)', 'Update existing records with newest incoming data', false),
                    const SizedBox(width: 12),
                    _buildStrategyOption('Quarantine / Flag', 'Ingest with duplicate flag for manual audit', false),
                    const SizedBox(width: 12),
                    _buildStrategyOption('Fail Pipeline', 'Strict abort on any duplicate detection', false),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Comparison of detected duplicates
          const Text('Duplicate Comparison Preview', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppTheme.surfaceDark,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.borderDark),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: AppTheme.warningAmber.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(4)),
                      child: const Text('CONFLICT #1 • Matched on Key: alex@example.com', style: TextStyle(color: AppTheme.warningAmber, fontSize: 11, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    // Original Row
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(color: AppTheme.cardDark, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppTheme.borderDark)),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Row 1 (Original)', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.successGreen, fontSize: 13)),
                                Text('KEEP', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.successGreen, fontSize: 11)),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text('Customer ID: 1001', style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                            Text('Name: Alex Johnson', style: TextStyle(fontSize: 12, color: AppTheme.textPrimary, fontWeight: FontWeight.bold)),
                            Text('Email: alex@example.com', style: TextStyle(fontSize: 12, color: AppTheme.primaryBlue)),
                            Text('Company: Demo Corporation', style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                            Text('Revenue: \$125,000.00', style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Icon(Icons.compare_arrows_rounded, color: AppTheme.textMuted, size: 28),
                    const SizedBox(width: 14),
                    // Duplicate Row
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppTheme.cardDark,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppTheme.warningAmber.withValues(alpha: 0.4)),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Row 418 (Duplicate)', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.warningAmber, fontSize: 13)),
                                Text('SKIP', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.warningAmber, fontSize: 11)),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text('Customer ID: 1418', style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                            Text('Name: Alexander Johnson', style: TextStyle(fontSize: 12, color: AppTheme.textPrimary, fontWeight: FontWeight.bold)),
                            Text('Email: alex@example.com', style: TextStyle(fontSize: 12, color: AppTheme.primaryBlue)),
                            Text('Company: Demo Corporation', style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                            Text('Revenue: \$130,000.00', style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStrategyOption(String title, String desc, bool isSelected) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryAccent.withValues(alpha: 0.15) : AppTheme.cardDark,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppTheme.primaryBlue : AppTheme.borderDark,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(isSelected ? Icons.radio_button_checked : Icons.radio_button_off, size: 16, color: isSelected ? AppTheme.primaryBlue : AppTheme.textMuted),
                const SizedBox(width: 8),
                Text(title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: isSelected ? Colors.white : AppTheme.textPrimary)),
              ],
            ),
            const SizedBox(height: 4),
            Text(desc, style: const TextStyle(fontSize: 11, color: AppTheme.textMuted)),
          ],
        ),
      ),
    );
  }
}

/// Screen for Final Import Result Summary
class ImportResultScreen extends StatelessWidget {
  final ValueChanged<String>? onNavigate;

  const ImportResultScreen({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Big Success Hero Banner
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.successGreen.withValues(alpha: 0.15),
                  AppTheme.surfaceDark,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.successGreen.withValues(alpha: 0.4)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.successGreen.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check_circle_rounded, color: AppTheme.successGreen, size: 40),
                ),
                const SizedBox(width: 20),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Import Completed Successfully',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Batch ingestion completed with isolate streaming. 9,842 clean records persisted to Customer Database in 1.15s.',
                        style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
                      ),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => onNavigate?.call('export_csv'),
                  icon: const Icon(Icons.download_rounded, size: 16),
                  label: const Text('Export Audit Log'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.cardDark,
                    foregroundColor: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Statistics Summary Cards
          Row(
            children: [
              _buildStatCard('Total Rows', '10,000', 'Full input volume', Icons.format_list_numbered_rounded, AppTheme.textSecondary),
              const SizedBox(width: 14),
              _buildStatCard('Successfully Persisted', '9,842', '98.42% ingestion rate', Icons.done_all_rounded, AppTheme.successGreen),
              const SizedBox(width: 14),
              _buildStatCard('Warnings Logged', '112', 'Coerced values', Icons.warning_amber_rounded, AppTheme.warningAmber),
              const SizedBox(width: 14),
              _buildStatCard('Errors Quarantined', '46', 'Exported to audit file', Icons.error_outline_rounded, AppTheme.errorRed),
              const SizedBox(width: 14),
              _buildStatCard('Processing Duration', '1.15s', '8,540 rows/sec', Icons.timer_rounded, AppTheme.primaryBlue),
            ],
          ),
          const SizedBox(height: 24),
          // Audit Log Breakdown
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
                const Text('Execution Run Details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                const SizedBox(height: 14),
                _buildAuditRow('Job Identifier', 'JOB-IMP-2026-0925-9842'),
                _buildAuditRow('Target Collection', 'customers (PostgreSQL Schema: public)'),
                _buildAuditRow('Source File', 'customers.xlsx (492 KB)'),
                _buildAuditRow('Parallel Isolates', '4 background thread workers'),
                _buildAuditRow('Memory Peak', '42.8 MB (Max allocated 68.4 MB)'),
                _buildAuditRow('Transaction State', 'COMMITTED (ACID isolated)'),
                const SizedBox(height: 20),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => onNavigate?.call('dashboard'),
                      icon: const Icon(Icons.dashboard_rounded, size: 16),
                      label: const Text('Return to Dashboard'),
                      style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryAccent, foregroundColor: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: () => onNavigate?.call('import_csv'),
                      icon: const Icon(Icons.upload_file_rounded, size: 16),
                      label: const Text('Start Another Import'),
                      style: OutlinedButton.styleFrom(foregroundColor: AppTheme.textSecondary),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String sub, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceDark,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppTheme.borderDark),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 10),
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
            const SizedBox(height: 2),
            Text(title, style: const TextStyle(fontSize: 12, color: AppTheme.textMuted)),
            Text(sub, style: TextStyle(fontSize: 10, color: color)),
          ],
        ),
      ),
    );
  }

  Widget _buildAuditRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(width: 180, child: Text(label, style: const TextStyle(color: AppTheme.textMuted, fontSize: 13))),
          Text(value, style: const TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.w600, fontSize: 13)),
        ],
      ),
    );
  }
}

// Helper
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
