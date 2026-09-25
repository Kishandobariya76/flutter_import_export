// ignore_for_file: avoid_print
import 'dart:io';

const screens = [
  'dashboard',
  'import_csv',
  'import_excel',
  'import_json',
  'file_preview',
  'column_mapping',
  'smart_mapping',
  'validation',
  'duplicate_detection',
  'transformation',
  'import_result',
  'export_csv',
  'export_excel',
  'export_json',
  'large_file_processing',
  'cancellation',
  'configuration_playground',
  'developer_mode',
  'import_inspector',
  'schema_inspector',
  'diagnostics',
  'logs',
  'error_details',
  'performance',
];

Future<void> main() async {
  final chromePath = '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome';
  final outDir = Directory('docs/screenshots');
  if (!outDir.existsSync()) {
    outDir.createSync(recursive: true);
  }

  print('Starting automated capture of ${screens.length} screens...');

  for (var i = 0; i < screens.length; i++) {
    final screen = screens[i];
    final targetPath = 'docs/screenshots/$screen.png';
    print('[${i + 1}/${screens.length}] Capturing $screen -> $targetPath');

    final result = await Process.run(chromePath, [
      '--headless=new',
      '--window-size=1440,900',
      '--virtual-time-budget=6000',
      '--screenshot=$targetPath',
      'http://localhost:8888/?screen=$screen',
    ]);

    final file = File(targetPath);
    if (file.existsSync() && file.lengthSync() > 1000) {
      print('  ✓ Successfully wrote ${file.lengthSync()} bytes');
    } else {
      stderr.writeln('  ✗ Failed to capture $screen. File size: ${file.existsSync() ? file.lengthSync() : 0}');
      if (result.stderr.toString().isNotEmpty) {
        stderr.writeln('    Chrome stderr: ${result.stderr}');
      }
    }
  }

  print('\nCapture process finished! Verifying all files:');
  var allOk = true;
  for (final screen in screens) {
    final f = File('docs/screenshots/$screen.png');
    if (!f.existsSync() || f.lengthSync() < 1000) {
      allOk = false;
      stderr.writeln('Missing or invalid: ${f.path}');
    } else {
      print('  ✓ $screen.png (${(f.lengthSync() / 1024).toStringAsFixed(1)} KB)');
    }
  }

  if (allOk) {
    print('\nALL ${screens.length} SCREENSHOTS VALIDATED SUCCESSFULLY!');
  } else {
    exit(1);
  }
}
