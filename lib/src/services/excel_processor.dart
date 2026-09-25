// Excel and spreadsheet processor

class ExcelSheetData {
  final String name;
  final List<String> headers;
  final List<List<dynamic>> rows;

  const ExcelSheetData({
    required this.name,
    required this.headers,
    required this.rows,
  });
}

class ExcelProcessor {
  /// Extract sheets and data from Excel representation.
  static List<ExcelSheetData> parseSpreadsheetMock({
    required String defaultSheetName,
    required List<String> headers,
    required List<List<dynamic>> rows,
  }) {
    return [
      ExcelSheetData(
        name: defaultSheetName,
        headers: headers,
        rows: rows,
      ),
    ];
  }

  /// Export records formatted as Excel XML / CSV workbook compatibility.
  static String exportXmlSpreadsheet({
    required String sheetName,
    required List<String> headers,
    required List<List<dynamic>> rows,
  }) {
    final buffer = StringBuffer();
    buffer.writeln('<?xml version="1.0"?>');
    buffer.writeln('<?mso-application progid="Excel.Sheet"?>');
    buffer.writeln(
        '<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"');
    buffer.writeln(' xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet">');
    buffer.writeln(' <Worksheet ss:Name="$sheetName">');
    buffer.writeln('  <Table>');

    // Headers
    buffer.writeln('   <Row ss:StyleID="HeaderStyle">');
    for (final h in headers) {
      buffer.writeln(
          '    <Cell><Data ss:Type="String">${_escapeXml(h)}</Data></Cell>');
    }
    buffer.writeln('   </Row>');

    // Rows
    for (final r in rows) {
      buffer.writeln('   <Row>');
      for (final cell in r) {
        final val = cell?.toString() ?? '';
        final isNum = num.tryParse(val) != null;
        final type = isNum ? 'Number' : 'String';
        buffer.writeln(
            '    <Cell><Data ss:Type="$type">${_escapeXml(val)}</Data></Cell>');
      }
      buffer.writeln('   </Row>');
    }

    buffer.writeln('  </Table>');
    buffer.writeln(' </Worksheet>');
    buffer.writeln('</Workbook>');
    return buffer.toString();
  }

  static String _escapeXml(String input) {
    return input
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&apos;');
  }
}
