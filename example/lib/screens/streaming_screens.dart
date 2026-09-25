import 'package:flutter/material.dart';
import '../widgets/app_theme.dart';

/// Screen for Large File Streaming & Chunking Monitor
class LargeFileProcessingScreen extends StatelessWidget {
  final ValueChanged<String>? onNavigate;

  const LargeFileProcessingScreen({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;

        final memoryCard = Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(color: AppTheme.surfaceDark, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppTheme.borderDark)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.memory_rounded, color: AppTheme.successGreen, size: 18),
                  SizedBox(width: 8),
                  Text('Memory Footprint (Flat Baseline)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                ],
              ),
              const SizedBox(height: 12),
              const Text('42.8 MB Current Heap', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
              const Text('Peak: 46.2 MB • No GC Spikes or Out-of-Memory Risks', style: TextStyle(fontSize: 12, color: AppTheme.textMuted)),
              const SizedBox(height: 12),
              Container(
                height: 38,
                decoration: BoxDecoration(color: AppTheme.cardDark, borderRadius: BorderRadius.circular(4)),
                child: Row(
                  children: List.generate(
                    24,
                    (i) => Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 1),
                        height: 18 + (i % 5) * 2.0,
                        color: AppTheme.successGreen.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );

        final workerCard = Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(color: AppTheme.surfaceDark, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppTheme.borderDark)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.hub_outlined, color: Color(0xFFA371F7), size: 18),
                  SizedBox(width: 8),
                  Text('Worker Isolate Pool (4 Active)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                ],
              ),
              const SizedBox(height: 12),
              _buildWorkerStatus('Isolate Worker #1', 'Parsing Chunk #296', AppTheme.primaryBlue),
              const SizedBox(height: 6),
              _buildWorkerStatus('Isolate Worker #2', 'Validating Chunk #295', AppTheme.successGreen),
              const SizedBox(height: 6),
              _buildWorkerStatus('Isolate Worker #3', 'Transforming Chunk #294', const Color(0xFFA371F7)),
              const SizedBox(height: 6),
              _buildWorkerStatus('Isolate Worker #4', 'Database Batch Writer', AppTheme.warningAmber),
            ],
          ),
        );

        return SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? 16.0 : 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isMobile) ...[
                _buildHeader(
                  title: 'Streaming & Chunking Monitor',
                  description: 'Ingesting 100,000 records in batches via isolate pool.',
                  icon: Icons.stream_rounded,
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () => onNavigate?.call('cancellation'),
                  icon: const Icon(Icons.cancel_outlined, size: 16),
                  label: const Text('Simulate Cancellation'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.errorRed,
                    side: const BorderSide(color: AppTheme.errorRed),
                  ),
                ),
              ] else ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: _buildHeader(
                        title: 'Large File Processing & Isolate Streaming',
                        description: 'Processing 100,000 records in streaming batches. Constant memory profile via Dart isolate worker pool.',
                        icon: Icons.stream_rounded,
                      ),
                    ),
                    const SizedBox(width: 16),
                    OutlinedButton.icon(
                      onPressed: () => onNavigate?.call('cancellation'),
                      icon: const Icon(Icons.cancel_outlined, size: 16),
                      label: const Text('Simulate User Cancellation'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.errorRed,
                        side: const BorderSide(color: AppTheme.errorRed),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 20),
              // Streaming Progress Hero Card
              Container(
                padding: EdgeInsets.all(isMobile ? 16 : 24),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceDark,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.borderDark),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isMobile) ...[
                      const Row(
                        children: [
                          SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2.5, color: AppTheme.primaryBlue),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Streaming Ingestion: 74,000 / 100k',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: AppTheme.primaryBlue.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(6)),
                        child: const Text('74.0% COMPLETED', style: TextStyle(color: AppTheme.primaryBlue, fontWeight: FontWeight.bold, fontSize: 11)),
                      ),
                    ] else ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(strokeWidth: 2.5, color: AppTheme.primaryBlue),
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Streaming Ingestion in Progress • 74,000 / 100,000 Rows',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(color: AppTheme.primaryBlue.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(6)),
                            child: const Text('74.0% COMPLETED', style: TextStyle(color: AppTheme.primaryBlue, fontWeight: FontWeight.bold, fontSize: 12)),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 18),
                    // Progress Bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: const LinearProgressIndicator(
                        value: 0.74,
                        minHeight: 12,
                        backgroundColor: AppTheme.cardDark,
                        color: AppTheme.primaryBlue,
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (isMobile) ...[
                      Row(
                        children: [
                          Expanded(child: _buildStatItem('Current Chunk', '#296 (250 rows)')),
                          Expanded(child: _buildStatItem('Throughput', '8,720 rows/s')),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(child: _buildStatItem('Elapsed Time', '8.48s')),
                          Expanded(child: _buildStatItem('ETA Remaining', '2.98s')),
                        ],
                      ),
                    ] else ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildStatItem('Current Chunk', 'Chunk #296 (Batch of 250 rows)'),
                          _buildStatItem('Throughput', '8,720 rows/second'),
                          _buildStatItem('Elapsed Time', '8.48 seconds'),
                          _buildStatItem('ETA Remaining', '2.98 seconds'),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Telemetry and Worker Grid
              if (isMobile)
                Column(
                  children: [
                    memoryCard,
                    const SizedBox(height: 16),
                    workerCard,
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(child: memoryCard),
                    const SizedBox(width: 16),
                    Expanded(child: workerCard),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: AppTheme.textMuted)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
      ],
    );
  }

  Widget _buildWorkerStatus(String name, String task, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
            const SizedBox(width: 8),
            Text(name, style: const TextStyle(fontSize: 12, color: AppTheme.textPrimary, fontWeight: FontWeight.w600)),
          ],
        ),
        Text(task, style: const TextStyle(fontSize: 11, color: AppTheme.textMuted)),
      ],
    );
  }
}

/// Screen for Cancellation & Rollback
class CancellationScreen extends StatelessWidget {
  final ValueChanged<String>? onNavigate;

  const CancellationScreen({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(
            title: 'Cancellation & Rollback Safety',
            description: 'Demonstrating graceful interruption via CancellationToken. Batches rolled back with zero partial data corruption.',
            icon: Icons.cancel_presentation_rounded,
          ),
          const SizedBox(height: 20),
          // Alert Card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppTheme.errorRed.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.errorRed.withValues(alpha: 0.4)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.warning_amber_rounded, color: AppTheme.errorRed, size: 36),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Import Pipeline Cancelled by Operator',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Cancellation token triggered at row 42,500 of 100,000. All worker isolates received termination signal. Uncommitted SQL transaction batch was aborted cleanly.',
                        style: TextStyle(fontSize: 13, color: AppTheme.textSecondary, height: 1.5),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 12,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => onNavigate?.call('dashboard'),
                            icon: const Icon(Icons.refresh_rounded, size: 16),
                            label: const Text('Return to Safe State'),
                            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.cardDark, foregroundColor: AppTheme.textPrimary),
                          ),
                          OutlinedButton.icon(
                            onPressed: () => onNavigate?.call('logs'),
                            icon: const Icon(Icons.list_alt_rounded, size: 16),
                            label: const Text('View Cancellation Logs'),
                            style: OutlinedButton.styleFrom(foregroundColor: AppTheme.textSecondary),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Safety Audit Matrix
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: AppTheme.surfaceDark, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppTheme.borderDark)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Transaction & Resource Teardown Checklist', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                const SizedBox(height: 14),
                _buildSafetyCheck('ACID Transaction Abort', 'Active database transaction executed ROLLBACK. 0 dirty records persisted.', true),
                _buildSafetyCheck('Isolate Worker Teardown', 'All 4 thread workers safely closed and disposed.', true),
                _buildSafetyCheck('File Stream Descriptor Release', 'Input stream buffer closed and file lock released.', true),
                _buildSafetyCheck('Memory Heap Reclaimed', 'Garbage collection reclaimed 28 MB buffer space.', true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSafetyCheck(String title, String desc, bool isPassed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(isPassed ? Icons.check_circle_rounded : Icons.cancel_rounded, color: isPassed ? AppTheme.successGreen : AppTheme.errorRed, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                Text(desc, style: const TextStyle(fontSize: 12, color: AppTheme.textMuted)),
              ],
            ),
          ),
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
