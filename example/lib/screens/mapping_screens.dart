import 'package:flutter/material.dart';
import '../widgets/app_theme.dart';

/// Screen for Column Mapping
class ColumnMappingScreen extends StatelessWidget {
  final ValueChanged<String>? onNavigate;

  const ColumnMappingScreen({super.key, this.onNavigate});

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
                title: 'Column Mapping: Target Schema Binding',
                description: 'Map incoming file columns to the Customer Schema. Confidence scores indicate smart auto-match accuracy.',
                icon: Icons.schema_rounded,
              ),
              Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: () => onNavigate?.call('smart_mapping'),
                    icon: const Icon(Icons.psychology_rounded, size: 16),
                    label: const Text('Smart Match Engine (96% Confidence)'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.primaryBlue,
                      side: const BorderSide(color: AppTheme.borderDark),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () => onNavigate?.call('validation'),
                    icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                    label: const Text('Validate Mapped Rows'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryAccent,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Mapping List Table
          Container(
            decoration: BoxDecoration(
              color: AppTheme.surfaceDark,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.borderDark),
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  decoration: const BoxDecoration(
                    color: AppTheme.cardDark,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  ),
                  child: const Row(
                    children: [
                      Expanded(flex: 3, child: Text('SOURCE COLUMN (INCOMING FILE)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppTheme.textPrimary))),
                      Expanded(flex: 1, child: Center(child: Text('MATCH', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppTheme.textMuted)))),
                      Expanded(flex: 3, child: Text('TARGET SCHEMA FIELD', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppTheme.textPrimary))),
                      Expanded(flex: 2, child: Text('DATA TYPE & CONSTRAINTS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppTheme.textPrimary))),
                      Expanded(flex: 2, child: Text('SAMPLE VALUE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppTheme.textPrimary))),
                    ],
                  ),
                ),
                // Rows
                _buildMappingRow(
                  sourceCol: 'id',
                  targetField: 'id (Customer ID)',
                  type: 'INTEGER',
                  isRequired: true,
                  confidence: 1.0,
                  sample: '1001',
                ),
                _buildDivider(),
                _buildMappingRow(
                  sourceCol: 'full_name',
                  targetField: 'name (Customer Name)',
                  type: 'STRING',
                  isRequired: true,
                  confidence: 0.94,
                  sample: 'Alex Johnson',
                  aliasMatched: 'full_name',
                ),
                _buildDivider(),
                _buildMappingRow(
                  sourceCol: 'contact_email',
                  targetField: 'email (Email Address)',
                  type: 'EMAIL',
                  isRequired: true,
                  confidence: 0.98,
                  sample: 'alex@example.com',
                  aliasMatched: 'contact_email',
                ),
                _buildDivider(),
                _buildMappingRow(
                  sourceCol: 'organization',
                  targetField: 'company (Company)',
                  type: 'STRING',
                  isRequired: false,
                  confidence: 0.91,
                  sample: 'Demo Corporation',
                  aliasMatched: 'organization',
                ),
                _buildDivider(),
                _buildMappingRow(
                  sourceCol: 'annual_revenue',
                  targetField: 'revenue (Annual Revenue)',
                  type: 'DECIMAL',
                  isRequired: false,
                  confidence: 0.88,
                  sample: '125000.00',
                ),
                _buildDivider(),
                _buildMappingRow(
                  sourceCol: 'account_status',
                  targetField: 'status (Account Status)',
                  type: 'ENUM',
                  isRequired: true,
                  confidence: 0.96,
                  sample: 'ACTIVE',
                  aliasMatched: 'account_status',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildInfoBanner('All 6 source columns successfully matched to target schema with >88% confidence. No unmapped columns detected.'),
        ],
      ),
    );
  }

  Widget _buildMappingRow({
    required String sourceCol,
    required String targetField,
    required String type,
    required bool isRequired,
    required double confidence,
    required String sample,
    String? aliasMatched,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          // Source Column
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.cardDark,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: AppTheme.borderDark),
                  ),
                  child: Text(
                    sourceCol,
                    style: const TextStyle(
                      fontFamily: 'Courier',
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: AppTheme.primaryBlue,
                    ),
                  ),
                ),
                if (aliasMatched != null) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFA371F7).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text('alias: $aliasMatched', style: const TextStyle(fontSize: 10, color: Color(0xFFA371F7))),
                  ),
                ],
              ],
            ),
          ),
          // Arrow / Confidence
          Expanded(
            flex: 1,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.arrow_forward, size: 14, color: AppTheme.textMuted),
                  const SizedBox(width: 4),
                  Text('${(confidence * 100).toInt()}%', style: const TextStyle(color: AppTheme.successGreen, fontSize: 11, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          // Target Field
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.cardDark,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppTheme.borderDark),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, size: 16, color: AppTheme.successGreen),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(targetField, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textPrimary)),
                  ),
                  const Icon(Icons.arrow_drop_down, size: 18, color: AppTheme.textSecondary),
                ],
              ),
            ),
          ),
          // Type & Constraints
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryBlue.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(type, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)),
                  ),
                  if (isRequired) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppTheme.errorRed.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text('REQUIRED', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppTheme.errorRed)),
                    ),
                  ],
                ],
              ),
            ),
          ),
          // Sample Value
          Expanded(
            flex: 2,
            child: Text(sample, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() => const Divider(height: 1, color: AppTheme.borderDark);
}

/// Screen for Smart Mapping Engine
class SmartMappingScreen extends StatelessWidget {
  final ValueChanged<String>? onNavigate;

  const SmartMappingScreen({super.key, this.onNavigate});

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
                title: 'Smart Matching Engine: Heuristics & Scoring',
                description: 'Underlying fuzzy matching, Levenshtein distance, token similarity, and dictionary alias resolver.',
                icon: Icons.psychology_rounded,
              ),
              ElevatedButton.icon(
                onPressed: () => onNavigate?.call('column_mapping'),
                icon: const Icon(Icons.arrow_back, size: 16),
                label: const Text('Back to Column Mapping'),
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.cardDark, foregroundColor: AppTheme.textPrimary),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left: Scoring Breakdown
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
                      const Text('Heuristic Matching Scores', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                      const SizedBox(height: 16),
                      _buildScoreDetail(
                        inputHeader: 'contact_email',
                        targetField: 'email',
                        algorithm: 'Alias Dictionary Lookup',
                        confidence: 0.98,
                        notes: 'Matched defined schema alias "contact_email" in CustomerSchema.',
                        color: AppTheme.successGreen,
                      ),
                      const SizedBox(height: 12),
                      _buildScoreDetail(
                        inputHeader: 'account_status',
                        targetField: 'status',
                        algorithm: 'Suffix / Token Overlap',
                        confidence: 0.96,
                        notes: 'Exact token match on "status" + schema alias "account_status".',
                        color: AppTheme.successGreen,
                      ),
                      const SizedBox(height: 12),
                      _buildScoreDetail(
                        inputHeader: 'full_name',
                        targetField: 'name',
                        algorithm: 'Stemming & Known Synonym',
                        confidence: 0.94,
                        notes: 'Matched alias "full_name" mapped to standard name field.',
                        color: AppTheme.successGreen,
                      ),
                      const SizedBox(height: 12),
                      _buildScoreDetail(
                        inputHeader: 'organization',
                        targetField: 'company',
                        algorithm: 'Thesaurus Synonym Resolver',
                        confidence: 0.91,
                        notes: 'Semantic equivalence: organization ↔ company.',
                        color: AppTheme.primaryBlue,
                      ),
                      const SizedBox(height: 12),
                      _buildScoreDetail(
                        inputHeader: 'annual_revenue',
                        targetField: 'revenue',
                        algorithm: 'Levenshtein Substring Distance',
                        confidence: 0.88,
                        notes: 'Target field "revenue" is exact substring with distance = 0.',
                        color: AppTheme.primaryBlue,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              // Right: Active Dictionary & Settings
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
                      const Text('Matching Parameters', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                      const SizedBox(height: 14),
                      _buildParamRow('Minimum Confidence Threshold', '50% (0.50)'),
                      _buildParamRow('Case Insensitive Normalization', 'Enabled'),
                      _buildParamRow('Punctuation Stripping', 'Enabled (_ - space)'),
                      _buildParamRow('Stemming & Lemmatization', 'Active (Porter Stemmer)'),
                      const SizedBox(height: 16),
                      const Divider(color: AppTheme.borderDark),
                      const SizedBox(height: 14),
                      const Text('Pre-Configured Aliases', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                      const SizedBox(height: 8),
                      _buildAliasChip('name', ['full_name', 'client_name', 'contact_name']),
                      const SizedBox(height: 6),
                      _buildAliasChip('email', ['e_mail', 'contact_email', 'email_address']),
                      const SizedBox(height: 6),
                      _buildAliasChip('company', ['org', 'organization', 'company_name']),
                      const SizedBox(height: 6),
                      _buildAliasChip('revenue', ['annual_revenue', 'rev', 'sales', 'arr']),
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

  Widget _buildScoreDetail({
    required String inputHeader,
    required String targetField,
    required String algorithm,
    required double confidence,
    required String notes,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.borderDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(inputHeader, style: const TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.bold, color: AppTheme.textPrimary, fontSize: 13)),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_right_alt, color: AppTheme.textMuted, size: 16),
                  const SizedBox(width: 8),
                  Text(targetField, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryBlue, fontSize: 13)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(4)),
                child: Text('${(confidence * 100).toInt()}% Confidence', style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text('Algorithm: $algorithm', style: const TextStyle(fontSize: 11, color: AppTheme.textMuted)),
          const SizedBox(height: 2),
          Text(notes, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
        ],
      ),
    );
  }

  Widget _buildParamRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
          Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
        ],
      ),
    );
  }

  Widget _buildAliasChip(String field, List<String> aliases) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 70, child: Text('$field:', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue))),
        Expanded(
          child: Wrap(
            spacing: 6,
            runSpacing: 4,
            children: aliases.map((a) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: AppTheme.cardDark, borderRadius: BorderRadius.circular(4), border: Border.all(color: AppTheme.borderDark)),
                child: Text(a, style: const TextStyle(fontSize: 10, color: AppTheme.textSecondary)),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

/// Screen for Transformation Pipeline
class TransformationScreen extends StatelessWidget {
  final ValueChanged<String>? onNavigate;

  const TransformationScreen({super.key, this.onNavigate});

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
                title: 'Data Transformation Pipeline',
                description: 'Pre-process and clean field values before database persistence. Chained operations execute in sequence.',
                icon: Icons.transform_rounded,
              ),
              ElevatedButton.icon(
                onPressed: () => onNavigate?.call('validation'),
                icon: const Icon(Icons.arrow_forward, size: 16),
                label: const Text('Apply & Re-Validate'),
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryAccent, foregroundColor: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Active Transformation Rules
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
                const Text('Configured Field Transformations', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                const SizedBox(height: 16),
                _buildTransformRule(
                  targetField: 'Customer Name (name)',
                  opName: 'Title Case Formatter',
                  opDescription: 'Capitalizes the first character of each word ("alex johnson" ➔ "Alex Johnson").',
                  sampleBefore: 'alex johnson',
                  sampleAfter: 'Alex Johnson',
                  color: AppTheme.primaryBlue,
                ),
                const SizedBox(height: 12),
                _buildTransformRule(
                  targetField: 'Email Address (email)',
                  opName: 'Trim Whitespace + Lowercase',
                  opDescription: 'Strips accidental spaces and normalizes RFC-5322 characters (" Alex@Example.COM " ➔ "alex@example.com").',
                  sampleBefore: ' Alex@Example.COM ',
                  sampleAfter: 'alex@example.com',
                  color: AppTheme.successGreen,
                ),
                const SizedBox(height: 12),
                _buildTransformRule(
                  targetField: 'Company (company)',
                  opName: 'Sanitize Characters + Default Fallback',
                  opDescription: 'Removes unprintable ASCII control characters. If empty, defaults to "Independent".',
                  sampleBefore: '[NULL]',
                  sampleAfter: 'Independent',
                  color: const Color(0xFFA371F7),
                ),
                const SizedBox(height: 12),
                _buildTransformRule(
                  targetField: 'Annual Revenue (revenue)',
                  opName: 'Currency Number Normalization',
                  opDescription: 'Strips currency symbols like "\$" or "USD" and parses to high-precision double.',
                  sampleBefore: '\$125,000.00',
                  sampleAfter: '125000.0',
                  color: AppTheme.warningAmber,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransformRule({
    required String targetField,
    required String opName,
    required String opDescription,
    required String sampleBefore,
    required String sampleAfter,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.borderDark),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(6)),
            child: Icon(Icons.auto_fix_high_rounded, color: color, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(targetField, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(4)),
                      child: Text(opName, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(opDescription, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(color: AppTheme.surfaceDark, borderRadius: BorderRadius.circular(4)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Sample: ', style: TextStyle(fontSize: 11, color: AppTheme.textMuted)),
                      Text(sampleBefore, style: const TextStyle(fontFamily: 'Courier', fontSize: 11, color: AppTheme.errorRed)),
                      const Text('  ➔  ', style: TextStyle(fontSize: 11, color: AppTheme.textMuted)),
                      Text(sampleAfter, style: const TextStyle(fontFamily: 'Courier', fontSize: 11, color: AppTheme.successGreen, fontWeight: FontWeight.bold)),
                    ],
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

Widget _buildInfoBanner(String text) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: AppTheme.successGreen.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: AppTheme.successGreen.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        const Icon(Icons.check_circle_outline, size: 16, color: AppTheme.successGreen),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12))),
      ],
    ),
  );
}
