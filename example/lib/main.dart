import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'screens/import_screens.dart';
import 'screens/mapping_screens.dart';
import 'screens/validation_screens.dart';
import 'screens/export_screens.dart';
import 'screens/streaming_screens.dart';
import 'screens/developer_screens.dart';
import 'widgets/app_scaffold.dart';
import 'widgets/app_theme.dart';

void main() {
  runApp(const FlutterImportExportExampleApp());
}

class FlutterImportExportExampleApp extends StatefulWidget {
  const FlutterImportExportExampleApp({super.key});

  @override
  State<FlutterImportExportExampleApp> createState() => _FlutterImportExportExampleAppState();
}

class _FlutterImportExportExampleAppState extends State<FlutterImportExportExampleApp> {
  String _activeScreenId = 'dashboard';

  @override
  void initState() {
    super.initState();
    // Read query parameter if running on Web
    final uri = Uri.base;
    if (uri.queryParameters.containsKey('screen')) {
      final requestedScreen = uri.queryParameters['screen']!;
      if (kScreenRegistry.any((s) => s['id'] == requestedScreen)) {
        _activeScreenId = requestedScreen;
      }
    }
  }

  void _navigateTo(String screenId) {
    setState(() {
      _activeScreenId = screenId;
    });
  }

  Widget _buildScreen(String screenId) {
    switch (screenId) {
      case 'dashboard':
        return DashboardScreen(onNavigate: _navigateTo);
      case 'import_csv':
        return ImportCsvScreen(onNavigate: _navigateTo);
      case 'import_excel':
        return ImportExcelScreen(onNavigate: _navigateTo);
      case 'import_json':
        return ImportJsonScreen(onNavigate: _navigateTo);
      case 'file_preview':
        return FilePreviewScreen(onNavigate: _navigateTo);
      case 'column_mapping':
        return ColumnMappingScreen(onNavigate: _navigateTo);
      case 'smart_mapping':
        return SmartMappingScreen(onNavigate: _navigateTo);
      case 'validation':
        return ValidationScreen(onNavigate: _navigateTo);
      case 'duplicate_detection':
        return DuplicateDetectionScreen(onNavigate: _navigateTo);
      case 'transformation':
        return TransformationScreen(onNavigate: _navigateTo);
      case 'import_result':
        return ImportResultScreen(onNavigate: _navigateTo);
      case 'export_csv':
        return ExportCsvScreen(onNavigate: _navigateTo);
      case 'export_excel':
        return ExportExcelScreen(onNavigate: _navigateTo);
      case 'export_json':
        return ExportJsonScreen(onNavigate: _navigateTo);
      case 'large_file_processing':
        return LargeFileProcessingScreen(onNavigate: _navigateTo);
      case 'cancellation':
        return CancellationScreen(onNavigate: _navigateTo);
      case 'configuration_playground':
        return ConfigurationPlaygroundScreen(onNavigate: _navigateTo);
      case 'developer_mode':
        return DeveloperModeScreen(onNavigate: _navigateTo);
      case 'import_inspector':
        return ImportInspectorScreen(onNavigate: _navigateTo);
      case 'schema_inspector':
        return SchemaInspectorScreen(onNavigate: _navigateTo);
      case 'diagnostics':
        return DiagnosticsScreen(onNavigate: _navigateTo);
      case 'logs':
        return LogsScreen(onNavigate: _navigateTo);
      case 'error_details':
        return ErrorDetailsScreen(onNavigate: _navigateTo);
      case 'performance':
        return PerformanceScreen(onNavigate: _navigateTo);
      default:
        return DashboardScreen(onNavigate: _navigateTo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Import Export Studio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme(),
      home: AppScaffold(
        currentScreenId: _activeScreenId,
        onNavigate: _navigateTo,
        child: _buildScreen(_activeScreenId),
      ),
    );
  }
}
