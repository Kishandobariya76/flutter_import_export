import 'package:flutter/material.dart';
import '../widgets/app_theme.dart';

/// Screen for Configuration Playground
class ConfigurationPlaygroundScreen extends StatelessWidget {
  final ValueChanged<String>? onNavigate;

  const ConfigurationPlaygroundScreen({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(
            title: 'Configuration Playground',
            description: 'Experiment with ingestion chunk sizes, error tolerances, isolate worker concurrency, and live Dart configurations.',
            icon: Icons.tune_rounded,
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left: Sliders and Toggles
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: AppTheme.surfaceDark, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppTheme.borderDark)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Pipeline Knobs & Tuning Parameters', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                      const SizedBox(height: 20),
                      _buildSliderRow('Chunk Size (Rows per batch)', '1,000 rows', 0.2, 'Small batches reduce memory latency; large batches increase raw throughput.'),
                      const SizedBox(height: 16),
                      _buildSliderRow('Max Error Tolerance Threshold', '50 errors', 0.1, 'Abort entire import if error count exceeds this threshold.'),
                      const SizedBox(height: 16),
                      _buildSliderRow('Isolate Worker Threads', '4 Isolates', 0.5, 'Parallel CPU cores allocated for deserialization and validation.'),
                      const SizedBox(height: 20),
                      const Divider(color: AppTheme.borderDark),
                      const SizedBox(height: 16),
                      _buildToggleRow('Strict Schema Mode', 'Reject records with undeclared excess columns', true),
                      const SizedBox(height: 10),
                      _buildToggleRow('Auto-Coerce Compatible Types', 'Convert numeric strings ("123") to integers automatically', true),
                      const SizedBox(height: 10),
                      _buildToggleRow('Simd / Vector Acceleration', 'Enable hardware-accelerated delimiter sniffing', true),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              // Right: Live Generated Dart Code
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: AppTheme.surfaceDark, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppTheme.borderDark)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.code_rounded, size: 18, color: AppTheme.primaryBlue),
                          SizedBox(width: 8),
                          Text('Generated Dart Code', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        width: double.infinity,
                        decoration: BoxDecoration(color: AppTheme.cardDark, borderRadius: BorderRadius.circular(6), border: Border.all(color: AppTheme.borderDark)),
                        child: const Text(
                          'final config = ImportConfig(\n'
                          '  chunkSize: 1000,\n'
                          '  maxErrorTolerance: 50,\n'
                          '  workerIsolates: 4,\n'
                          '  strictSchema: true,\n'
                          '  autoCoerceTypes: true,\n'
                          '  hardwareAcceleration: true,\n'
                          '  duplicateStrategy: DuplicateStrategy.skip,\n'
                          ');\n\n'
                          'final pipeline = StreamingImporter(\n'
                          '  config: config,\n'
                          '  schema: CustomerSchema.v1,\n'
                          ');\n\n'
                          'await for (final progress in pipeline.run()) {\n'
                          '  print("Processed \${progress.percentage}%");\n'
                          '}',
                          style: TextStyle(fontFamily: 'Courier', fontSize: 11, color: Color(0xFF58A6FF), height: 1.4),
                        ),
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

  Widget _buildSliderRow(String title, String valText, double value, String desc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
            Text(valText, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)),
          ],
        ),
        const SizedBox(height: 4),
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 4,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
            activeTrackColor: AppTheme.primaryBlue,
            inactiveTrackColor: AppTheme.cardDark,
            thumbColor: AppTheme.primaryBlue,
          ),
          child: Slider(value: value, onChanged: (_) {}),
        ),
        Text(desc, style: const TextStyle(fontSize: 11, color: AppTheme.textMuted)),
      ],
    );
  }
}

/// Screen for Developer Mode & State
class DeveloperModeScreen extends StatelessWidget {
  final ValueChanged<String>? onNavigate;

  const DeveloperModeScreen({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(
            title: 'Developer Mode: Runtime Inspector & Bus State',
            description: 'Internal package telemetry, execution pipeline state, isolate worker metrics, and diagnostics hooks.',
            icon: Icons.developer_mode_rounded,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildDevTile('Active Pipeline State', 'IDLE (Ready for Ingestion)', Icons.sync_rounded, AppTheme.successGreen),
              const SizedBox(width: 14),
              _buildDevTile('Isolate Workers', '4 Standby / 0 Active', Icons.hub_rounded, AppTheme.primaryBlue),
              const SizedBox(width: 14),
              _buildDevTile('GC Heap Memory', '42.8 MB / 68.4 MB Peak', Icons.memory_rounded, const Color(0xFFA371F7)),
              const SizedBox(width: 14),
              _buildDevTile('Event Bus Listeners', '12 Active Streams', Icons.cable_rounded, AppTheme.warningAmber),
            ],
          ),
          const SizedBox(height: 20),
          // Runtime Flags Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: AppTheme.surfaceDark, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppTheme.borderDark)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Active Developer & Debug Flags', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                const SizedBox(height: 14),
                _buildFlagRow('kDebugMode', 'TRUE', 'Dart runtime debug assertions enabled'),
                _buildFlagRow('kProfileMode', 'FALSE', 'Standard execution profile'),
                _buildFlagRow('IsolateWorkerPool.enabled', 'TRUE', 'Multi-threaded background task processing'),
                _buildFlagRow('DiagnosticsLogger.verbose', 'TRUE', 'Emitting full chunk telemetry events'),
                _buildFlagRow('ValidationEngine.fastFail', 'FALSE', 'Full error inspection (collect all errors)'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDevTile(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppTheme.surfaceDark, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppTheme.borderDark)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label, style: const TextStyle(fontSize: 11, color: AppTheme.textMuted)),
                Icon(icon, color: color, size: 18),
              ],
            ),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
          ],
        ),
      ),
    );
  }

  Widget _buildFlagRow(String key, String value, String desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(color: AppTheme.cardDark, borderRadius: BorderRadius.circular(4)),
            child: Text(key, style: const TextStyle(fontFamily: 'Courier', fontSize: 12, color: AppTheme.primaryBlue)),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(color: AppTheme.successGreen.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(4)),
            child: Text(value, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.successGreen)),
          ),
          const SizedBox(width: 14),
          Expanded(child: Text(desc, style: const TextStyle(fontSize: 12, color: AppTheme.textMuted))),
        ],
      ),
    );
  }
}

/// Screen for Import Session Inspector
class ImportInspectorScreen extends StatelessWidget {
  final ValueChanged<String>? onNavigate;

  const ImportInspectorScreen({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(
            title: 'Import Session Inspector: IMP-2026-0925-9842',
            description: 'Deep audit trace for the last executed import batch: byte hashes, chunk allocations, and timing traces.',
            icon: Icons.find_in_page_rounded,
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: AppTheme.surfaceDark, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppTheme.borderDark)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Session Ingestion Metadata', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                const SizedBox(height: 14),
                _buildInfoLine('Session UUID', 'c84a7e91-6204-43b9-8e5b-3b8c2810a9f2'),
                _buildInfoLine('Source File Name', 'customers.xlsx (492,118 bytes)'),
                _buildInfoLine('Source MD5 Checksum', '3a4f89b2c89012e84129e71b29a14f6d'),
                _buildInfoLine('Schema Association', 'CustomerSchema v1.2.0 (Strict mode)'),
                _buildInfoLine('Total Ingested Rows', '10,000 records partitioned across 40 chunks'),
                _buildInfoLine('Valid Committed Rows', '9,842 (98.42%)'),
                _buildInfoLine('Quarantined Errors', '46 records written to error_quarantine.csv'),
                _buildInfoLine('Warnings Handled', '112 field transformations applied'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoLine(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(width: 200, child: Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.textMuted))),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textPrimary))),
        ],
      ),
    );
  }
}

/// Screen for Schema Definition Inspector
class SchemaInspectorScreen extends StatelessWidget {
  final ValueChanged<String>? onNavigate;

  const SchemaInspectorScreen({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(
            title: 'Schema Inspector: CustomerSchema v1.2.0',
            description: 'Visual AST representation of target schema fields, types, unique keys, and validation rules.',
            icon: Icons.account_tree_rounded,
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: AppTheme.surfaceDark, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppTheme.borderDark)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Customer Data Contract', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                    Text('Unique Constraints: [email]', style: TextStyle(fontSize: 12, color: AppTheme.primaryBlue, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 16),
                _buildFieldCard('id', 'Customer ID', 'FieldType.integer', 'Required: true • Primary Identifier', ['cust_id', 'id', 'account_id']),
                const SizedBox(height: 10),
                _buildFieldCard('name', 'Customer Name', 'FieldType.string', 'Required: true • MinLength: 2', ['full_name', 'client_name', 'name']),
                const SizedBox(height: 10),
                _buildFieldCard('email', 'Email Address', 'FieldType.email', 'Required: true • UniqueKey • Regex: RFC-5322', ['e_mail', 'contact_email']),
                const SizedBox(height: 10),
                _buildFieldCard('company', 'Company Name', 'FieldType.string', 'Required: false • Default: "Independent"', ['org', 'organization']),
                const SizedBox(height: 10),
                _buildFieldCard('revenue', 'Annual Revenue', 'FieldType.decimal', 'Required: false • Range: [0.0, 10,000,000.0]', ['annual_revenue', 'sales']),
                const SizedBox(height: 10),
                _buildFieldCard('status', 'Account Status', 'FieldType.enumType', 'Required: true • Allowed: [ACTIVE, PENDING, INACTIVE]', ['state', 'account_status']),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldCard(String key, String label, String type, String rules, List<String> aliases) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppTheme.cardDark, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppTheme.borderDark)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: AppTheme.surfaceDark, borderRadius: BorderRadius.circular(4)),
            child: Text(key, style: const TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.bold, fontSize: 13, color: AppTheme.primaryBlue)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                    const SizedBox(width: 8),
                    Text(type, style: const TextStyle(fontSize: 11, color: AppTheme.textMuted)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(rules, style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Text('Aliases: ', style: TextStyle(fontSize: 10, color: AppTheme.textMuted)),
                    Text(aliases.join(', '), style: const TextStyle(fontSize: 11, color: Color(0xFFA371F7))),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Screen for System Diagnostics
class DiagnosticsScreen extends StatelessWidget {
  final ValueChanged<String>? onNavigate;

  const DiagnosticsScreen({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(
            title: 'System Diagnostics & Platform Capabilities',
            description: 'Hardware acceleration, Flutter engine version, Dart runtime capabilities, and isolate thread pool health.',
            icon: Icons.monitor_heart_rounded,
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: AppTheme.surfaceDark, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppTheme.borderDark)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Runtime Environment Profile', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                const SizedBox(height: 16),
                _buildDiagRow('Flutter Framework Version', 'Flutter 3.44.0 (Channel: stable)'),
                _buildDiagRow('Dart Runtime Engine', 'Dart 3.12.0 (macOS darwin-arm64 / Web)'),
                _buildDiagRow('Hardware CPU Architecture', 'ARM64 (Apple Silicon NEON SIMD enabled)'),
                _buildDiagRow('Isolate Concurrency Pool', '4 Workers Spawned & Ready'),
                _buildDiagRow('Streaming Backpressure Buffer', '0 Dropped Frames • Low Watermark Healthy'),
                _buildDiagRow('Memory Heap Allocation', '42.8 MB Current / 68.4 MB Peak All-Time'),
                _buildDiagRow('Total Import Jobs Recorded', '128 Jobs (1,280,000 rows cumulative)'),
                _buildDiagRow('Average Ingestion Speed', '8,540 rows/second across all formats'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiagRow(String title, String val) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: AppTheme.cardDark, borderRadius: BorderRadius.circular(4), border: Border.all(color: AppTheme.borderDark)),
            child: Text(val, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
          ),
        ],
      ),
    );
  }
}

/// Screen for Structured Event Logs
class LogsScreen extends StatelessWidget {
  final ValueChanged<String>? onNavigate;

  const LogsScreen({super.key, this.onNavigate});

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
                title: 'Structured Event Logs',
                description: 'Real-time telemetry stream from file sniffers, parsers, validators, and database ingestion controllers.',
                icon: Icons.receipt_long_rounded,
              ),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.file_download_outlined, size: 16),
                label: const Text('Export Logs (.log)'),
                style: OutlinedButton.styleFrom(foregroundColor: AppTheme.textSecondary),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(color: AppTheme.surfaceDark, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppTheme.borderDark)),
            child: Column(
              children: [
                _buildLogItem('15:42:01.102', 'INFO', 'FILE_SNIFFER', 'Detected format XLSX: 3 sheets found in customers.xlsx (492 KB)', AppTheme.primaryBlue),
                _buildLogDivider(),
                _buildLogItem('15:42:01.115', 'DEBUG', 'SCHEMA_BIND', 'Auto-matched 6/6 columns to CustomerSchema with 96% mean confidence', AppTheme.textMuted),
                _buildLogDivider(),
                _buildLogItem('15:42:01.120', 'INFO', 'ISOLATE_POOL', 'Spawned 4 background workers for parallel chunk stream processing', AppTheme.primaryBlue),
                _buildLogDivider(),
                _buildLogItem('15:42:01.350', 'WARN', 'VALIDATOR', 'Row 142: Negative revenue -\$1,200.00 coerced to range minimum', AppTheme.warningAmber),
                _buildLogDivider(),
                _buildLogItem('15:42:01.520', 'ERROR', 'VALIDATOR', 'Row 47: Invalid email syntax "alex.invalid-email". Missing domain.', AppTheme.errorRed),
                _buildLogDivider(),
                _buildLogItem('15:42:02.250', 'INFO', 'COMMIT_SVC', 'Committed 9,842 rows into target table in 1.15s (8,540 rows/sec)', AppTheme.successGreen),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogItem(String time, String level, String tag, String msg, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Text(time, style: const TextStyle(fontFamily: 'Courier', fontSize: 11, color: AppTheme.textMuted)),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(4)),
            child: Text(level, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 10),
          Text('[$tag]', style: const TextStyle(fontFamily: 'Courier', fontSize: 11, color: AppTheme.textSecondary, fontWeight: FontWeight.bold)),
          const SizedBox(width: 14),
          Expanded(child: Text(msg, style: const TextStyle(fontSize: 12, color: AppTheme.textPrimary))),
        ],
      ),
    );
  }

  Widget _buildLogDivider() => const Divider(height: 1, color: AppTheme.borderDark);
}

/// Screen for Error Details Inspection Drawer
class ErrorDetailsScreen extends StatelessWidget {
  final ValueChanged<String>? onNavigate;

  const ErrorDetailsScreen({super.key, this.onNavigate});

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
                title: 'Error Diagnostic: ERR-ROW-47-EMAIL',
                description: 'Detailed inspection drawer for validation error on line 48 of customers.xlsx.',
                icon: Icons.bug_report_rounded,
              ),
              ElevatedButton.icon(
                onPressed: () => onNavigate?.call('validation'),
                icon: const Icon(Icons.arrow_back, size: 16),
                label: const Text('Back to Validation Report'),
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.cardDark, foregroundColor: AppTheme.textPrimary),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppTheme.surfaceDark,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.errorRed.withValues(alpha: 0.4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: AppTheme.errorRed.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(4)),
                      child: const Text('SEVERITY: BLOCKING ERROR', style: TextStyle(color: AppTheme.errorRed, fontSize: 11, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 12),
                    const Text('Violated Rule: ValidationRule.email (RFC-5322)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppTheme.textPrimary)),
                  ],
                ),
                const SizedBox(height: 18),
                _buildDetailItem('Offending Field', 'email (Email Address)'),
                _buildDetailItem('Raw Ingested Value', '"alex.invalid-email"'),
                _buildDetailItem('File Location', 'customers.xlsx ➔ Sheet: "Customers" ➔ Row 47, Column C'),
                _buildDetailItem('Root Cause Analysis', 'Input string lacks top-level domain extension (e.g. .com, .org). Regular expression match failed.'),
                _buildDetailItem('Suggested Remediation', 'Check customer record for typos. Ensure valid RFC-5322 format: user@domain.com.'),
                const SizedBox(height: 18),
                const Text('Complete Row JSON Dump', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  width: double.infinity,
                  decoration: BoxDecoration(color: AppTheme.cardDark, borderRadius: BorderRadius.circular(6), border: Border.all(color: AppTheme.borderDark)),
                  child: const Text(
                    '{\n  "row_number": 47,\n  "raw_values": {\n    "id": 1047,\n    "name": "Alex Johnson",\n    "email": "alex.invalid-email",\n    "company": "Demo Corp",\n    "revenue": 125000,\n    "status": "ACTIVE"\n  }\n}',
                    style: TextStyle(fontFamily: 'Courier', fontSize: 12, color: AppTheme.errorRed, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 180, child: Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.textMuted))),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textPrimary))),
        ],
      ),
    );
  }
}

/// Screen for Performance Benchmarks & Metrics
class PerformanceScreen extends StatelessWidget {
  final ValueChanged<String>? onNavigate;

  const PerformanceScreen({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(
            title: 'Performance Benchmarks & Memory Telemetry',
            description: 'Execution speed across varying row volumes (10k, 50k, 100k, 500k), parser latency, and memory footprint.',
            icon: Icons.speed_rounded,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildBenchmarkCard('Peak Throughput', '8,540', 'rows / second', AppTheme.primaryBlue),
              const SizedBox(width: 14),
              _buildBenchmarkCard('10,000 Rows Ingestion', '1.15s', 'Total execution duration', AppTheme.successGreen),
              const SizedBox(width: 14),
              _buildBenchmarkCard('Validation Latency', '85 ms', 'Across 6 schema fields', const Color(0xFFA371F7)),
              const SizedBox(width: 14),
              _buildBenchmarkCard('Max Memory Spike', '42.8 MB', 'Constant streaming profile', AppTheme.warningAmber),
            ],
          ),
          const SizedBox(height: 20),
          // Format Performance Comparison Table
          Container(
            decoration: BoxDecoration(color: AppTheme.surfaceDark, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppTheme.borderDark)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(AppTheme.cardDark),
                columnSpacing: 28,
                headingTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textPrimary, fontSize: 13),
                columns: const [
                  DataColumn(label: Text('DATA FORMAT')),
                  DataColumn(label: Text('10,000 ROWS')),
                  DataColumn(label: Text('50,000 ROWS')),
                  DataColumn(label: Text('100,000 ROWS')),
                  DataColumn(label: Text('THROUGHPUT')),
                  DataColumn(label: Text('PEAK HEAP')),
                ],
                rows: const [
                  DataRow(cells: [
                    DataCell(Text('CSV (Streaming)', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryBlue))),
                    DataCell(Text('0.82s')),
                    DataCell(Text('3.95s')),
                    DataCell(Text('7.80s')),
                    DataCell(Text('12,800 rows/s', style: TextStyle(color: AppTheme.successGreen, fontWeight: FontWeight.bold))),
                    DataCell(Text('38.4 MB')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Excel XLSX (OpenXML)', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF107C41)))),
                    DataCell(Text('1.15s')),
                    DataCell(Text('5.80s')),
                    DataCell(Text('11.45s')),
                    DataCell(Text('8,720 rows/s', style: TextStyle(color: AppTheme.successGreen, fontWeight: FontWeight.bold))),
                    DataCell(Text('42.8 MB')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('JSON (Path Traversal)', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFF16529)))),
                    DataCell(Text('0.98s')),
                    DataCell(Text('4.85s')),
                    DataCell(Text('9.60s')),
                    DataCell(Text('10,400 rows/s', style: TextStyle(color: AppTheme.successGreen, fontWeight: FontWeight.bold))),
                    DataCell(Text('44.1 MB')),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenchmarkCard(String title, String value, String unit, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppTheme.surfaceDark, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppTheme.borderDark)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 12, color: AppTheme.textMuted)),
            const SizedBox(height: 8),
            Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 2),
            Text(unit, style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
          ],
        ),
      ),
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
