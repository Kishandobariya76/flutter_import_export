# Screenshot Regeneration Guide

This document describes how to capture and update the visual documentation for **Flutter Import Export**.

All visual artifacts in `docs/screenshots/` are captured directly from the actual running example application using deterministic datasets.

---

## 📸 Screenshot Directory Structure

Screenshots are organized in:

```text
docs/
└── screenshots/
    ├── dashboard.png
    ├── import_csv.png
    ├── import_excel.png
    ├── import_json.png
    ├── file_preview.png
    ├── column_mapping.png
    ├── smart_mapping.png
    ├── validation.png
    ├── duplicate_detection.png
    ├── transformation.png
    ├── import_result.png
    ├── export_csv.png
    ├── export_excel.png
    ├── export_json.png
    ├── large_file_processing.png
    ├── cancellation.png
    ├── configuration_playground.png
    ├── developer_mode.png
    ├── import_inspector.png
    ├── schema_inspector.png
    ├── diagnostics.png
    ├── logs.png
    ├── error_details.png
    └── performance.png
```

---

## 🔒 Deterministic Demo Data Requirements

To guarantee visual consistency and reproducibility across versions, all screenshots must use deterministic demo fixtures.

Screenshots **must never** depend on:
* Dynamic current timestamps or dates
* Randomly generated numbers or names
* Live remote APIs or third-party web services
* Local user-specific file paths or accounts

### Standard Benchmark Scenario

| Metric | Target Value |
|---|---|
| Ingestion Target File | `customers.xlsx` |
| Total Ingested Volume | `10,000 records` |
| Successfully Committed | `9,842 rows (98.4%)` |
| Validation Warnings | `112 rows (1.1%)` |
| Quarantined Errors | `46 rows (0.5%)` |
| Processing Duration | `1.15 seconds` |
| Average Throughput | `8,540 rows/second` |
| Cumulative Imports | `128` |
| Cumulative Exports | `74` |
| Resolved Errors | `12` |

### Standard Demo Customer Fixture

```text
Customer ID: 1001
Customer Name: Alex Johnson
Email: alex@example.com
Company: Demo Corporation
Annual Revenue: $125,000.00
Account Status: ACTIVE
```

---

## 🚀 How to Run the Example Application

### Prerequisites

* Flutter SDK 3.44.0 (Dart 3.12.0)
* Path: `/Volumes/MiniPart/Development/FlutterSDK/flutter-3.44.0`
* Google Chrome (for automated headless rendering)

### Running Interactively

```bash
cd example
flutter run -d chrome
```

Or on desktop macOS:

```bash
cd example
flutter run -d macos
```

### Navigating to Individual Screens

The application includes an in-app screen switcher at the top right of the navigation bar, and also supports direct routing via query parameter:

```text
http://localhost:8888/?screen=dashboard
http://localhost:8888/?screen=column_mapping
http://localhost:8888/?screen=validation
http://localhost:8888/?screen=import_result
```

---

## 🤖 Automated Screenshot Capture Pipeline

We provide an automated regeneration script located in `tool/`:

1. **Build the Example Web Application**:
   ```bash
   cd example
   flutter build web
   cd ..
   ```

2. **Launch the Local HTTP Static Server**:
   ```bash
   dart tool/server.dart 8888
   ```

3. **Execute the Automated Batch Capture Script**:
   ```bash
   dart tool/capture_all.dart
   ```

The script will:
* Launch headless Google Chrome at Retina resolution (`1440x900`)
* Allow the Flutter Web engine to initialize and settle
* Sequentially capture each of the 24 screens
* Validate file size and write directly to `docs/screenshots/<screen_id>.png`

---

## 📋 Screenshot Coverage & README Mapping

| Screen ID | Target File | README Section |
|---|---|---|
| `dashboard` | `dashboard.png` | Hero Screenshot & Dashboard Overview |
| `import_csv` | `import_csv.png` | CSV Ingestion & Delimiter Detection |
| `import_excel` | `import_excel.png` | Multi-Sheet Excel (XLSX) Workbooks |
| `import_json` | `import_json.png` | JSON & JSONL Path Traversal |
| `file_preview` | `file_preview.png` | Data Grid File Preview & Type Inference |
| `column_mapping` | `column_mapping.png` | Schema Binding & Confidence Badges |
| `smart_mapping` | `smart_mapping.png` | Fuzzy Matching & Alias Engine |
| `validation` | `validation.png` | Pre-Persistence Validation & Issue Matrix |
| `duplicate_detection` | `duplicate_detection.png` | Unique Key Conflict Resolution |
| `transformation` | `transformation.png` | Data Transformation Pipeline |
| `import_result` | `import_result.png` | Execution Summary & Audit Report |
| `export_csv` | `export_csv.png` | CSV Export & Delimiter Settings |
| `export_excel` | `export_excel.png` | Styled XLSX Workbook Generation |
| `export_json` | `export_json.png` | JSON Serialization & Pretty-Printing |
| `large_file_processing` | `large_file_processing.png` | Streaming, Chunking & Isolate Concurrency |
| `cancellation` | `cancellation.png` | CancellationToken & Safe Rollback |
| `configuration_playground` | `configuration_playground.png` | Interactive Settings & Tuning Knobs |
| `developer_mode` | `developer_mode.png` | Developer Mode & Runtime Flags |
| `import_inspector` | `import_inspector.png` | Session Ingestion Telemetry Trace |
| `schema_inspector` | `schema_inspector.png` | Schema AST & Field Rule Definition |
| `diagnostics` | `diagnostics.png` | Platform Capabilities & Engine Health |
| `logs` | `logs.png` | Structured Event Logging Console |
| `error_details` | `error_details.png` | Field-Level Error Remediation Drawer |
| `performance` | `performance.png` | Benchmarks & Throughput Profiles |

---

## 🔍 Validation Checklist Before Release

* [x] Screenshots captured from actual example app
* [x] No placeholder images or mockups
* [x] No broken image links in `README.md`
* [x] No sensitive or personal user information
* [x] All 24 screenshot files exist in `docs/screenshots/`
* [x] Dark mode developer UI system used consistently
