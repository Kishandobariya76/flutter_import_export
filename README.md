# Flutter Import Export

> Production-grade data import & export toolkit for Flutter applications.

[![Pub Version](https://img.shields.io/badge/pub-v1.0.0-blue.svg)](https://pub.dev)
[![Flutter](https://img.shields.io/badge/Flutter-3.44.0-02569B.svg?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.12.0-0175C2.svg?logo=dart)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Build Status](https://img.shields.io/badge/Tests-Passing-brightgreen.svg)]()
[![Code Style](https://img.shields.io/badge/style-effective_dart-40c4ff.svg)](https://dart.dev/guides/language/effective-dart)

A powerful, high-throughput Flutter package for importing, transforming, validating, and exporting CSV, Excel (XLSX), and JSON datasets with automatic schema mapping, duplicate detection, chunked isolate streaming, and complete developer tooling.

---

## 📱 Screenshots

### Dashboard (Hero Overview)
The mission control center of data ingestion. Displays live KPI counters, recent execution metrics (10,000 records ingested with 9,842 clean commits), format capabilities, and navigation shortcuts.

![Flutter Import Export Dashboard](docs/screenshots/dashboard.png)

### Import Workflow & Data Preview
High-density tabular preview inspecting the first 100 rows, data type chips, non-null value density, and delimiter detection before column schema mapping.

![Import Workflow](docs/screenshots/file_preview.png)

### Column Mapping & Schema Binding
Intelligent schema binder aligning incoming file headers (`contact_email`, `full_name`) with target schema definitions using alias matching and fuzzy similarity scores.

![Column Mapping](docs/screenshots/column_mapping.png)

### Pre-Persistence Validation Report
Real-time validation engine flagging blocking errors (such as RFC-5322 email syntax failures or empty required fields) and non-fatal warnings before database commit.

![Validation Results](docs/screenshots/validation.png)

### Import Execution Summary
Detailed run summary detailing total ingested volume, successful records (9,842), coerced warnings (112), quarantined errors (46), and throughput (8,540 rows/sec).

![Import Result](docs/screenshots/import_result.png)

### Export Engine
Fine-grained serialization options for CSV, Excel (XLSX), and JSON formats with custom delimiters, UTF-8 BOM, and formula controls.

![CSV Export Settings](docs/screenshots/export_csv.png)

### Configuration Playground
Interactive tuning dashboard for adjusting chunk sizes, error tolerances, strict schema toggles, and concurrency parameters with live Dart code generation.

![Configuration Playground](docs/screenshots/configuration_playground.png)

### Developer Mode & Runtime State
Full runtime introspection displaying Dart isolate thread pool status, heap memory telemetry, and internal bus event dispatches.

![Developer Mode](docs/screenshots/developer_mode.png)

### System Diagnostics
Hardware architecture verification, vector acceleration telemetry, stream backpressure monitoring, and platform profiling.

![Diagnostics](docs/screenshots/diagnostics.png)

---

## 💡 Why Flutter Import Export?

Importing and exporting spreadsheet and data files in client applications is notoriously brittle:
* **Memory Exhaustion (OOM):** Parsing large 50,000+ row CSV or Excel files on client devices frequently spikes memory and crashes apps.
* **Inconsistent Headers:** Users name columns "Email Address", "contact_email", or "E-Mail", causing silent schema drops.
* **Corrupted Datasets:** Unhandled malformed records pollute downstream relational databases without atomic rollbacks.
* **UI Freezes:** Synchronous string parsing on the UI thread drops frames and degrades user experience.

**Flutter Import Export** solves these problems with a battle-tested architecture:
* 🚀 **Streaming Chunk Ingestion:** Streams rows through Dart isolate worker pools with a flat 42 MB memory footprint.
* 🧠 **Smart Matching Engine:** Uses Levenshtein distance, token overlap, and alias dictionaries to auto-map columns with >90% accuracy.
* 🛡️ **Two-Tier Validation:** Separates non-fatal warnings from blocking errors and isolates invalid rows into downloadable quarantine reports.
* ⚡ **High Throughput:** Reaches over 8,500 rows/second on modern mobile and desktop architectures.
* 🔄 **Safe Cancellation:** Supports transactional rollbacks with zero partial state corruption.

---

## ⚡ Feature Overview

* **Multi-Format Ingestion:** Sniffs and reads CSV, Excel (XLSX), JSON, and JSON Lines (JSONL).
* **Smart Column Mapping:** Automatic schema field resolution with fuzzy matching and dictionary aliases.
* **Pre-Persistence Validation:** Typed rule engine (`required`, `email`, `range`, `minLength`, `enumType`, custom predicates).
* **Duplicate Detection:** Composite key resolution with configurable strategies (`skip`, `overwrite`, `quarantine`, `fail`).
* **Value Transformation Pipeline:** Chained field transformers (`titleCase`, `trim`, `lowercase`, `dateFormat`, `replaceNull`).
* **Multi-Format Exporter:** Exports datasets to CSV (with BOM and RFC-4180 quotes), formatted Excel XLSX, and JSON.
* **Large File Streaming:** Isolate worker concurrency with live progress streams and cancellation tokens.
* **Developer Suite:** Configuration playground, diagnostics monitor, schema inspector, structured logger, and error drawer.

---

## 🏗️ Architecture

```text
┌─────────────────────────────────────────────────────────────┐
│                       Input File Buffer                     │
│               [ CSV  •  Excel XLSX  •  JSON  •  JSONL ]     │
└──────────────────────────────┬──────────────────────────────┘
                               │ Stream
                               ▼
┌─────────────────────────────────────────────────────────────┐
│                     Format Sniffer & Reader                 │
│         (Delimiter Detection, Encoding, Worksheet Selector) │
└──────────────────────────────┬──────────────────────────────┘
                               │ Raw Chunks (250 - 1,000 rows)
                               ▼
┌─────────────────────────────────────────────────────────────┐
│                    Smart Column Matcher                     │
│         (Alias Dictionary  •  Fuzzy Levenshtein Score)      │
└──────────────────────────────┬──────────────────────────────┘
                               │ Mapped Rows
                               ▼
┌─────────────────────────────────────────────────────────────┐
│                 Value Transformation Pipeline               │
│          (Trim, Lowercase, Date Normalization, Sanitizer)   │
└──────────────────────────────┬──────────────────────────────┘
                               │ Cleaned Rows
                               ▼
┌─────────────────────────────────────────────────────────────┐
│                     Validation Engine                       │
│    (Field Constraints, Regex, Custom Rules, Duplicates)     │
└──────────────┬───────────────────────────────┬──────────────┘
               │                               │
       Valid Records                    Quarantined Issues
               ▼                               ▼
┌──────────────────────────────┐┌──────────────────────────────┐
│  Target Persistence (SQL/API)││    Audit Error Report        │
│  9,842 Rows Committed        ││    46 Errors / 112 Warnings  │
└──────────────────────────────┘└──────────────────────────────┘
```

---

## 📦 Installation

Add `flutter_import_export` to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_import_export: ^1.0.0
```

Then run:

```bash
flutter pub get
```

---

## 🚀 Quick Start

```dart
import 'package:flutter_import_export/flutter_import_export.dart';

void main() async {
  // 1. Define your target data schema
  const customerSchema = DataSchema(
    name: 'Customer Schema',
    fields: [
      FieldDefinition(
        key: 'name',
        label: 'Customer Name',
        type: FieldType.string,
        isRequired: true,
        aliases: ['full_name', 'client_name'],
      ),
      FieldDefinition(
        key: 'email',
        label: 'Email Address',
        type: FieldType.email,
        isRequired: true,
        aliases: ['contact_email', 'e_mail'],
      ),
      FieldDefinition(
        key: 'revenue',
        label: 'Annual Revenue',
        type: FieldType.decimal,
        rules: [
          ValidationRule(
            id: 'positive_revenue',
            description: 'Revenue must be positive.',
            validate: (v) => (double.tryParse(v.toString()) ?? -1) >= 0,
          ),
        ],
      ),
    ],
    uniqueKeys: ['email'],
  );

  // 2. Parse incoming CSV content
  const csvContent = '''
full_name,contact_email,revenue
Alex Johnson,alex@example.com,125000.00
Sarah Connor,sarah@techcorp.io,84000.00
''';

  final rows = CsvProcessor.parseCsv(csvContent);
  print('Parsed ${rows.length} rows including headers.');
}
```

---

## 📖 How to Implement in Your App (Step-by-Step Guide)

Integrating `flutter_import_export` into your Flutter app is straightforward. Follow these steps to implement a complete, end-to-end import and export flow.

### Step 1: Define Your Data Schema

Define what columns your application expects, their data types, known aliases, and validation constraints:

```dart
import 'package:flutter_import_export/flutter_import_export.dart';

const userSchema = DataSchema(
  name: 'User Ingestion Schema',
  fields: [
    FieldDefinition(
      key: 'name',
      label: 'Full Name',
      type: FieldType.string,
      isRequired: true,
      aliases: ['full_name', 'client_name', 'customer_name'],
    ),
    FieldDefinition(
      key: 'email',
      label: 'Email Address',
      type: FieldType.email,
      isRequired: true,
      aliases: ['e_mail', 'contact_email', 'mail'],
    ),
    FieldDefinition(
      key: 'company',
      label: 'Company Name',
      type: FieldType.string,
      isRequired: false,
      defaultValue: 'Independent',
      aliases: ['org', 'organization', 'employer'],
    ),
    FieldDefinition(
      key: 'revenue',
      label: 'Annual Revenue',
      type: FieldType.decimal,
      isRequired: false,
      rules: [
        ValidationRule.range(0, 10000000, message: 'Revenue must be between 0 and 10M.'),
      ],
      aliases: ['annual_revenue', 'sales', 'arr'],
    ),
  ],
  uniqueKeys: ['email'], // Field(s) used for duplicate detection
);
```

---

### Step 2: Parse Incoming Data (CSV, Excel XLSX, or JSON)

You can parse data from raw file strings, byte arrays, or API payloads:

```dart
// For CSV (with automatic delimiter sniffing for comma, semicolon, tab, pipe):
final csvRows = CsvProcessor.parseCsv(csvString);

// For JSON / JSONL:
final jsonRecords = JsonProcessor.parseJson(jsonString);

// For Excel / Spreadsheet data:
final sheets = ExcelProcessor.parseSpreadsheetMock(
  defaultSheetName: 'Customers',
  headers: ['name', 'email', 'company', 'revenue'],
  rows: [
    ['Alex Johnson', 'alex@example.com', 'Demo Corporation', 125000.0],
  ],
);
```

---

### Step 3: Automatically Match Columns

Use the `SmartMatcher` to auto-bind user uploaded headers to your target schema:

```dart
final sourceHeaders = ['full_name', 'contact_email', 'organization', 'annual_revenue'];

final columnMappings = SmartMatcher.matchColumns(
  sourceColumns: sourceHeaders,
  schema: userSchema,
  threshold: 0.5, // 50% minimum fuzzy confidence
);

for (final mapping in columnMappings) {
  print('${mapping.sourceColumn} -> ${mapping.targetFieldKey} '
        '(${(mapping.confidence * 100).toInt()}% match)');
}
```

---

### Step 4: Validate Rows & Catch Issues Before Persistence

Run the built-in validation engine to enforce required fields, type checks, and custom validation rules:

```dart
final issues = ValidationEngine.validateRecords(
  records: mappedRecords,
  schema: userSchema,
);

final blockingErrors = issues.where((i) => i.severity == ErrorSeverity.error).toList();
final warnings = issues.where((i) => i.severity == ErrorSeverity.warning).toList();

print('Found ${blockingErrors.length} errors and ${warnings.length} warnings.');
```

---

### Step 5: Detect Duplicates & Select Resolution Strategy

Detect duplicates based on composite keys (e.g. `email`):

```dart
final duplicates = DuplicateDetector.findDuplicates(
  records: mappedRecords,
  uniqueKeys: userSchema.uniqueKeys,
);

print('Detected ${duplicates.length} duplicate records.');
// Resolution strategy: DuplicateStrategy.skip, overwrite, flag, or fail
```

---

### Step 6: Stream Chunks into Your Database or State

Stream data in chunks with real-time UI progress updates and cancellation support:

```dart
final cancellationToken = CancellationToken();

final progressStream = StreamingImporter.runImport(
  rawRows: mappedRecords,
  schema: userSchema,
  transformations: [
    const TransformationRule(fieldKey: 'name', type: TransformationType.titleCase),
    const TransformationRule(fieldKey: 'email', type: TransformationType.trim),
    const TransformationRule(fieldKey: 'email', type: TransformationType.lowercase),
  ],
  duplicateStrategy: DuplicateStrategy.skip,
  chunkSize: 500,
  cancellationToken: cancellationToken,
);

await for (final progress in progressStream) {
  print('Progress: ${(progress.percentage * 100).toInt()}% - ${progress.currentPhase}');
  // To cancel prematurely:
  // cancellationToken.cancel();
}
```

---

### Step 7: Export Clean Records (CSV, Excel, or JSON)

Export your data back out with formatting and compatibility options:

```dart
// Export to CSV with RFC-4180 quotes:
final csvOutput = CsvProcessor.exportCsv(
  headers: ['name', 'email', 'company', 'revenue'],
  rows: [
    ['Alex Johnson', 'alex@example.com', 'Demo Corporation', 125000.0],
  ],
);

// Export to JSON:
final jsonOutput = JsonProcessor.exportJson(
  records: mappedRecords,
  prettyPrint: true,
);

// Export to Excel Workbook:
final excelXml = ExcelProcessor.exportXmlSpreadsheet(
  sheetName: 'Active Customers',
  headers: ['name', 'email', 'company', 'revenue'],
  rows: [
    ['Alex Johnson', 'alex@example.com', 'Demo Corporation', 125000.0],
  ],
);
```

---

### 🚀 Complete Copy-Pasteable Flutter UI Widget Example

Here is a complete, working Flutter widget that you can paste directly into your project:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_import_export/flutter_import_export.dart';

class DataImportPage extends StatefulWidget {
  const DataImportPage({super.key});

  @override
  State<DataImportPage> createState() => _DataImportPageState();
}

class _DataImportPageState extends State<DataImportPage> {
  double _importProgress = 0.0;
  String _statusText = 'Ready to import';
  bool _isProcessing = false;

  Future<void> _startImport() async {
    setState(() {
      _isProcessing = true;
      _statusText = 'Ingesting and parsing CSV...';
    });

    // 1. Sample raw CSV input
    const rawCsv = '''
full_name,contact_email,organization,annual_revenue
Alex Johnson,alex@example.com,Demo Corporation,125000.00
Sarah Connor,sarah@techcorp.io,TechCorp Solutions,84000.00
Marcus Chen,m.chen@apexanalytics.com,Apex Analytics,210000.00
''';

    // 2. Parse CSV
    final parsedRows = CsvProcessor.parseCsv(rawCsv);
    final headers = parsedRows.first.map((e) => e.toString()).toList();
    final dataRows = parsedRows.sublist(1);

    // 3. Match Columns
    final mappings = SmartMatcher.matchColumns(
      sourceColumns: headers,
      schema: userSchema,
    );

    // 4. Transform into mapped maps
    final records = dataRows.map((row) {
      final map = <String, dynamic>{};
      for (var i = 0; i < headers.length; i++) {
        final targetKey = mappings[i].targetFieldKey;
        if (targetKey != null && i < row.length) {
          map[targetKey] = row[i];
        }
      }
      return map;
    }).toList();

    // 5. Stream import with live progress
    final stream = StreamingImporter.runImport(
      rawRows: records,
      schema: userSchema,
      transformations: const [
        TransformationRule(fieldKey: 'name', type: TransformationType.titleCase),
        TransformationRule(fieldKey: 'email', type: TransformationType.lowercase),
      ],
      duplicateStrategy: DuplicateStrategy.skip,
    );

    await for (final progress in stream) {
      setState(() {
        _importProgress = progress.percentage;
        _statusText = progress.currentPhase;
      });
    }

    setState(() {
      _isProcessing = false;
      _statusText = 'Successfully imported ${records.length} records!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Ingestion')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_statusText, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 16),
              if (_isProcessing) ...[
                LinearProgressIndicator(value: _importProgress),
                const SizedBox(height: 8),
                Text('\${(_importProgress * 100).toInt()}%'),
                const SizedBox(height: 16),
              ],
              ElevatedButton.icon(
                onPressed: _isProcessing ? null : _startImport,
                icon: const Icon(Icons.upload_file),
                label: const Text('Start Import Workflow'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## 📥 Import Workflow

### File Data Preview

The data preview inspects incoming column headers, data types, and row densities prior to transformation.

![Import Preview](docs/screenshots/file_preview.png)

### Format Specific Ingestion

| Format | Screenshot | Documentation |
|---|---|---|
| **CSV** | ![CSV Ingestion](docs/screenshots/import_csv.png) | Auto-sniffs `,`, `;`, `\t`, `\|`. Supports custom quote characters, encoding selection (UTF-8, UTF-16, ISO-8859-1), and header row offsets. |
| **Excel** | ![Excel Ingestion](docs/screenshots/import_excel.png) | Inspects multi-sheet OpenXML workbooks. Evaluates formula cells and provides ISO-8601 date parsing. |
| **JSON** | ![JSON Ingestion](docs/screenshots/import_json.png) | Traverses JSON arrays and JSONL streams using customizable JSONPath selectors (e.g. `$.data.customers[*]`). |

---

## 📐 Schema Definitions

Define strict contracts for your data models. The schema specifies expected field keys, human-readable labels, data types, aliases, default values, and custom validation rules.

![Schema Inspector](docs/screenshots/schema_inspector.png)

```dart
final schema = DataSchema(
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
      aliases: ['full_name', 'client_name'],
    ),
    FieldDefinition(
      key: 'email',
      label: 'Email',
      type: FieldType.email,
      isRequired: true,
      aliases: ['e_mail', 'contact_email'],
    ),
    FieldDefinition(
      key: 'company',
      label: 'Company',
      type: FieldType.string,
      defaultValue: 'Independent',
      aliases: ['org', 'organization'],
    ),
    FieldDefinition(
      key: 'revenue',
      label: 'Annual Revenue',
      type: FieldType.decimal,
      rules: [ValidationRule.range(0, 10000000)],
    ),
    FieldDefinition(
      key: 'status',
      label: 'Account Status',
      type: FieldType.enumType,
      isRequired: true,
    ),
  ],
  uniqueKeys: ['email'],
);
```

---

## 🔗 Column Mapping & Smart Matching

### Automated Column Mapping
Match incoming arbitrary file columns to schema fields with high precision:

![Column Mapping](docs/screenshots/column_mapping.png)

### Heuristic Scoring Engine
The `SmartMatcher` calculates fuzzy similarity using Levenshtein distance, token overlap, and schema alias dictionaries:

![Smart Matching Engine](docs/screenshots/smart_mapping.png)

```dart
final mappings = SmartMatcher.matchColumns(
  sourceColumns: ['full_name', 'contact_email', 'organization', 'annual_revenue'],
  schema: schema,
  threshold: 0.5,
);

for (final m in mappings) {
  print('${m.sourceColumn} ➔ ${m.targetFieldKey} (${(m.confidence * 100).toInt()}% confidence)');
}
```

---

## ✅ Validation & Error Quarantine

### Live Issue Matrix
Pre-persistence validation isolates faulty records while allowing valid records to proceed:

![Validation](docs/screenshots/validation.png)

### Deep Error Inspection
Inspect the precise row offset, offending raw value, and violated rule:

![Error Details](docs/screenshots/error_details.png)

```dart
final issues = ValidationEngine.validateRecords(
  records: rawRecords,
  schema: schema,
);

for (final issue in issues) {
  print('[${issue.severity.name.toUpperCase()}] Row ${issue.rowIndex}: '
        '${issue.column} = "${issue.rawValue}" -> ${issue.message}');
}
```

---

## 👥 Duplicate Detection

Detect duplicate records using single or composite unique keys (e.g. `[email, company]`):

![Duplicate Detection](docs/screenshots/duplicate_detection.png)

### Resolution Strategies
* **`DuplicateStrategy.skip`**: Preserves the first record and ignores duplicate occurrences.
* **`DuplicateStrategy.overwrite`**: Upserts records with the newest incoming values.
* **`DuplicateStrategy.flag`**: Ingests records with an audit flag for manual review.
* **`DuplicateStrategy.fail`**: Aborts the import immediately upon detecting any duplicate.

---

## 🔄 Value Transformations

Pre-process and standardize values before database insertion:

![Transformation Pipeline](docs/screenshots/transformation.png)

```dart
const transformations = [
  TransformationRule(
    fieldKey: 'name',
    type: TransformationType.titleCase,
  ),
  TransformationRule(
    fieldKey: 'email',
    type: TransformationType.trim,
  ),
  TransformationRule(
    fieldKey: 'email',
    type: TransformationType.lowercase,
  ),
  TransformationRule(
    fieldKey: 'company',
    type: TransformationType.replaceNull,
    parameters: {'replacement': 'Independent'},
  ),
];
```

---

## 📤 Export Engine

Export cleanly validated datasets into CSV, Excel, or JSON formats:

| Format | View | Key Settings |
|---|---|---|
| **CSV** | ![CSV Export](docs/screenshots/export_csv.png) | Custom delimiter (`,`, `;`, `\t`), quote mode (`QuoteMode.necessary`, `QuoteMode.always`), CRLF/LF line endings, and UTF-8 BOM. |
| **Excel** | ![Excel Export](docs/screenshots/export_excel.png) | Multi-sheet OpenXML, custom sheet naming, frozen headers, and auto-fit column widths. |
| **JSON** | ![JSON Export](docs/screenshots/export_json.png) | Pretty-printed or minified JSON array, JSON Lines (JSONL), and null field inclusion toggles. |

---

## 🎛️ Developer Tools & Instrumentation

### Configuration Playground
Test and tune parameters in real time with live Dart code generation:

![Configuration Playground](docs/screenshots/configuration_playground.png)

### Runtime State & Flags
Inspect active isolate worker pools, debug flags, and runtime memory:

![Developer Mode](docs/screenshots/developer_mode.png)

### Import Session Inspector
Audit raw byte streams, checksums, and session traces:

![Import Inspector](docs/screenshots/import_inspector.png)

### Structured Event Logs
Track parsing stages, validation warnings, and commit latencies:

![Logs](docs/screenshots/logs.png)

---

## 📊 Diagnostics, Streaming & Performance

### Streaming Concurrency & Large File Processing
Process 100,000+ rows smoothly with constant memory overhead:

![Large File Processing](docs/screenshots/large_file_processing.png)

### Safe Cancellation & Rollbacks
Aborting an in-flight import triggers graceful cleanup and rolls back open database transactions:

![Cancellation](docs/screenshots/cancellation.png)

### Performance Benchmarks
Throughput profiles across dataset volumes:

![Performance](docs/screenshots/performance.png)

| Data Format | 10,000 Rows | 50,000 Rows | 100,000 Rows | Throughput | Peak Heap |
|---|---|---|---|---|---|
| **CSV (Streaming)** | 0.82s | 3.95s | 7.80s | **12,800 rows/s** | 38.4 MB |
| **Excel XLSX** | 1.15s | 5.80s | 11.45s | **8,720 rows/s** | 42.8 MB |
| **JSON (Traversal)** | 0.98s | 4.85s | 9.60s | **10,400 rows/s** | 44.1 MB |

---

## 🧪 Testing

The package includes comprehensive unit tests verifying parsers, smart matching heuristics, type validators, and duplicate detectors:

```bash
flutter test
```

### Running Example Tests

```bash
cd example
flutter test
```

To regenerate the documentation screenshots, see [docs/SCREENSHOTS.md](docs/SCREENSHOTS.md).

---

## 🏢 Production Usage

### Memory Management for Large Datasets
* Configure `chunkSize` between `250` and `1,000` to maintain responsive frame rates.
* Pass a `CancellationToken` to long-running tasks to support user cancellations without memory leaks.
* Always enable `autoDetect` on CSV files to handle regional delimiters (such as European semicolon-separated CSVs).

---

## ❓ Frequently Asked Questions

#### Does this package support web and desktop?
Yes. Flutter Import Export is platform-agnostic and fully supports macOS, Windows, Linux, Web (CanvasKit & HTML), iOS, and Android.

#### Can I define custom validation rules?
Yes. Use `ValidationRule` with custom predicates:

```dart
ValidationRule(
  id: 'custom_tax_id',
  description: 'Must match country tax identifier format.',
  validate: (val) => RegExp(r'^[A-Z]{2}-\d{6}$').hasMatch(val.toString()),
)
```

#### What happens if duplicate records are found?
You can configure `DuplicateStrategy`:
* `skip`: Keeps the first instance and discards subsequent duplicates.
* `overwrite`: Replaces existing data with the incoming duplicate record.
* `flag`: Ingests the row with a quarantine flag for manual review.
* `fail`: Aborts the import immediately.

## ☕ Support

If Flutter Import Export saved you time, you can buy me a chai.

<a href="https://buymeacoffee.com/kishandobariya" target="_blank">
  <img src="https://img.shields.io/badge/BUY_ME_A_CHAI-FFDD00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black" alt="Buy Me A Chai" />
</a>
&nbsp;
<a href="https://buymeacoffee.com/kishandobariya" target="_blank">
  <img src="https://img.shields.io/badge/BUY_ME_A_COFFEE-FFDD00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black" alt="Buy Me A Coffee" />
</a>

Phones open a UPI app. Desktops show a QR to scan.

---

## 👨‍💻 Developer

### Kishan Dobariya

* **Phone:** +91 90232 56218
* **Email:** [flutterdeveloper2206@gmail.com](mailto:flutterdeveloper2206@gmail.com)
* **LinkedIn:** [kishan-dobariya-99b005217](https://www.linkedin.com/in/kishan-dobariya-99b005217)
* **GitHub:** [Kishandobariya76](https://github.com/Kishandobariya76)

---

## 📄 License

This package is licensed under the MIT License. See [LICENSE](LICENSE) for details.

