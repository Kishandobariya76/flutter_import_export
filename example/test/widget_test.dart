import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/main.dart';

void main() {
  testWidgets('FlutterImportExportExampleApp loads dashboard smoke test', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const FlutterImportExportExampleApp());
    await tester.pumpAndSettle();

    expect(find.text('Flutter Import Export'), findsOneWidget);
    expect(find.text('Production Data Import & Export Toolkit'), findsOneWidget);
    expect(find.text('Total Imports'), findsOneWidget);
    expect(find.text('customers.xlsx'), findsOneWidget);
  });
}
