# Changelog

All notable changes to this project will be documented in this file.

## 1.0.1

* **Fix:** Relaxed Dart SDK environment constraint to `sdk: ">=3.0.0 <4.0.0"` and `flutter: ">=3.0.0"` for stable Flutter 3.x and Dart 3.0+ compatibility.
* **Fix:** Broadened `csv` dependency constraint to `csv: ">=6.0.0 <9.0.0"`.
* **Fix:** Replaced version-specific parser with universal `CsvToListConverter` and `ListToCsvConverter` supporting multi-platform line endings (`\r\n`, `\n`).
* **Fix:** Resolved duplicate closure argument warning in `ImportExportDataTable`.

## 1.0.0

* **Initial Production Release of `flutter_import_export`**
* Comprehensive multi-format import engine:
  * CSV Parser with automated delimiter auto-detection (`,`, `;`, `\t`, `|`).
  * Excel (XLSX) processor with multi-sheet inspection and formula evaluation.
  * JSON / JSONL processor with JSONPath querying and streaming support.
* Production export engine:
  * CSV exporter with configurable quoting modes, delimiters, and UTF-8 BOM.
  * Excel exporter with custom sheet naming and auto-fit column widths.
  * JSON exporter supporting formatted arrays and streaming JSONL.
* Schema Mapping & Smart Matching:
  * Automated column matching with Levenshtein fuzzy distance, phonetic Soundex, and synonyms.
  * Custom column mapping builder with transformation pipelines.
* Validation & Duplicate Detection:
  * Rule-based field validation (required, email, numeric, regex, min/max).
  * High-performance single-pass duplicate detector using composite keys.
* UI Widgets & Responsive Table:
  * `ImportExportDataTable`: Responsive, paginated, dual-axis scrolling data table with sortable columns.
  * `TableDesignConfig`: Custom styling system for border colors, border widths, corner radius, zebra striping, and 5 pre-built presets (`dark`, `light`, `oceanNavy`, `emerald`, `minimalBordered`).
* Streaming & Background Processing:
  * Chunked streaming importer for large files with pause, resume, and cancellation tokens.
  * Progress streams with throughput metrics and diagnostics.
