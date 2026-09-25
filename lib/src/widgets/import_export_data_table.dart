import 'package:flutter/material.dart';
import 'table_design_config.dart';

/// Column definition for [ImportExportDataTable].
class TableColumnDef {
  /// Unique key matching the map entry in rows.
  final String key;

  /// Primary title rendered in the table header.
  final String title;

  /// Optional subtitle or data type badge (e.g. "STRING", "INTEGER").
  final String? subTitle;

  /// Fixed width for this column, or null for automatic sizing.
  final double? width;

  /// Text alignment inside cells of this column.
  final Alignment alignment;

  /// Whether clicking this column toggles sorting.
  final bool sortable;

  const TableColumnDef({
    required this.key,
    required this.title,
    this.subTitle,
    this.width,
    this.alignment = Alignment.centerLeft,
    this.sortable = true,
  });

  /// Quick helper from simple key/title.
  factory TableColumnDef.fromKey(String key, {String? subTitle}) {
    return TableColumnDef(
      key: key,
      title: key,
      subTitle: subTitle,
    );
  }
}

/// A responsive, highly customizable data table widget for displaying
/// imported or exported datasets with full control over borders,
/// header colors, alternating row zebra-striping, and pagination.
class ImportExportDataTable extends StatefulWidget {
  /// Definitions for each column to display.
  final List<TableColumnDef> columns;

  /// Data rows as a list of key-value maps.
  final List<Map<String, dynamic>> rows;

  /// Styling configuration for colors, borders, fonts, and gridlines.
  final TableDesignConfig designConfig;

  /// Optional custom cell renderer for custom formatting or badges.
  /// If returns null, falls back to standard text renderer.
  final Widget? Function(BuildContext context, int rowIndex, String columnKey, dynamic value)? cellBuilder;

  /// Optional custom header renderer.
  final Widget Function(BuildContext context, TableColumnDef column)? headerBuilder;

  /// Callback when a row is tapped.
  final ValueChanged<Map<String, dynamic>>? onRowTap;

  /// Whether to display a row index number column on the left.
  final bool showIndexColumn;

  /// Header title for the row index column.
  final String indexColumnTitle;

  /// Number of rows to display per page.
  final int pageSize;

  /// Whether to render the pagination footer.
  final bool showPagination;

  /// Minimum width of the table. Useful on mobile to enable smooth horizontal swiping.
  final double minWidth;

  /// Message to show when [rows] is empty.
  final String emptyMessage;

  const ImportExportDataTable({
    super.key,
    required this.columns,
    required this.rows,
    this.designConfig = const TableDesignConfig(),
    this.cellBuilder,
    this.headerBuilder,
    this.onRowTap,
    this.showIndexColumn = true,
    this.indexColumnTitle = '#',
    this.pageSize = 10,
    this.showPagination = true,
    this.minWidth = 650.0,
    this.emptyMessage = 'No data available to display.',
  });

  @override
  State<ImportExportDataTable> createState() => _ImportExportDataTableState();
}

class _ImportExportDataTableState extends State<ImportExportDataTable> {
  int _currentPage = 0;
  String? _sortColumnKey;
  bool _sortAscending = true;

  List<Map<String, dynamic>> get _sortedRows {
    if (_sortColumnKey == null) return widget.rows;

    final sorted = List<Map<String, dynamic>>.from(widget.rows);
    sorted.sort((a, b) {
      final valA = a[_sortColumnKey];
      final valB = b[_sortColumnKey];

      if (valA == null && valB == null) return 0;
      if (valA == null) return _sortAscending ? -1 : 1;
      if (valB == null) return _sortAscending ? 1 : -1;

      if (valA is Comparable && valB is Comparable) {
        return _sortAscending ? Comparable.compare(valA, valB) : Comparable.compare(valB, valA);
      }
      return _sortAscending
          ? valA.toString().compareTo(valB.toString())
          : valB.toString().compareTo(valA.toString());
    });
    return sorted;
  }

  int get _totalPages {
    if (widget.rows.isEmpty) return 1;
    return (widget.rows.length / widget.pageSize).ceil();
  }

  List<Map<String, dynamic>> get _pagedRows {
    final sorted = _sortedRows;
    if (!widget.showPagination) return sorted;

    final start = _currentPage * widget.pageSize;
    if (start >= sorted.length) return [];
    final end = (start + widget.pageSize).clamp(0, sorted.length);
    return sorted.sublist(start, end);
  }

  void _onSort(String key) {
    setState(() {
      if (_sortColumnKey == key) {
        _sortAscending = !_sortAscending;
      } else {
        _sortColumnKey = key;
        _sortAscending = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cfg = widget.designConfig;
    final pagedRows = _pagedRows;
    final totalRows = widget.rows.length;

    return Container(
      decoration: BoxDecoration(
        color: cfg.rowBackgroundColor,
        borderRadius: cfg.borderRadius,
        border: Border.all(
          color: cfg.borderColor,
          width: cfg.borderWidth,
        ),
      ),
      child: ClipRRect(
        borderRadius: cfg.borderRadius,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Horizontally Scrollable Table Canvas
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: widget.minWidth),
                child: DataTable(
                  headingRowHeight: cfg.headerHeight,
                  dataRowMinHeight: cfg.rowHeight,
                  dataRowMaxHeight: cfg.rowHeight,
                  columnSpacing: cfg.columnSpacing,
                  horizontalMargin: 16.0,
                  showBottomBorder: cfg.showHorizontalGridLines,
                  dividerThickness: cfg.showHorizontalGridLines ? cfg.gridLineWidth : 0.0,
                  headingRowColor: WidgetStateProperty.all(cfg.headerBackgroundColor),
                  dataRowColor: WidgetStateProperty.resolveWith<Color?>((states) {
                    if (states.contains(WidgetState.hovered) && cfg.rowHoverColor != null) {
                      return cfg.rowHoverColor;
                    }
                    return null; // Will apply alternate styling in cell rows
                  }),
                  border: TableBorder(
                    verticalInside: cfg.showVerticalGridLines
                        ? BorderSide(color: cfg.gridLineColor, width: cfg.gridLineWidth)
                        : BorderSide.none,
                    horizontalInside: cfg.showHorizontalGridLines
                        ? BorderSide(color: cfg.gridLineColor, width: cfg.gridLineWidth)
                        : BorderSide.none,
                  ),
                  columns: _buildColumns(cfg),
                  rows: _buildRows(pagedRows, cfg),
                ),
              ),
            ),
            // Empty State Notice
            if (widget.rows.isEmpty)
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Center(
                  child: Text(
                    widget.emptyMessage,
                    style: TextStyle(
                      color: cfg.cellTextStyle?.color?.withValues(alpha: 0.6) ?? Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            // Pagination Footer Bar
            if (widget.showPagination && widget.rows.isNotEmpty)
              _buildPaginationBar(cfg, totalRows),
          ],
        ),
      ),
    );
  }

  List<DataColumn> _buildColumns(TableDesignConfig cfg) {
    final cols = <DataColumn>[];

    if (widget.showIndexColumn) {
      cols.add(
        DataColumn(
          label: Text(
            widget.indexColumnTitle,
            style: cfg.headerTextStyle ??
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey),
          ),
        ),
      );
    }

    for (final col in widget.columns) {
      final isSorted = _sortColumnKey == col.key;
      cols.add(
        DataColumn(
          onSort: col.sortable ? (_, _) => _onSort(col.key) : null,
          label: widget.headerBuilder != null
              ? widget.headerBuilder!(context, col)
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          col.title,
                          style: cfg.headerTextStyle ??
                              const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.white,
                              ),
                        ),
                        if (col.subTitle != null)
                          Text(
                            col.subTitle!,
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              color: cfg.headerTextStyle?.color?.withValues(alpha: 0.7) ??
                                  const Color(0xFF58A6FF),
                            ),
                          ),
                      ],
                    ),
                    if (isSorted) ...[
                      const SizedBox(width: 4),
                      Icon(
                        _sortAscending ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                        size: 14,
                        color: cfg.headerTextStyle?.color ?? Colors.white,
                      ),
                    ],
                  ],
                ),
        ),
      );
    }

    return cols;
  }

  List<DataRow> _buildRows(List<Map<String, dynamic>> pagedRows, TableDesignConfig cfg) {
    final startIndex = widget.showPagination ? _currentPage * widget.pageSize : 0;

    return pagedRows.asMap().entries.map((entry) {
      final localIdx = entry.key;
      final globalIdx = startIndex + localIdx + 1;
      final row = entry.value;

      final isOdd = localIdx % 2 != 0;
      final rowColor = (isOdd && cfg.alternateRowBackgroundColor != null)
          ? cfg.alternateRowBackgroundColor!
          : cfg.rowBackgroundColor;

      final cells = <DataCell>[];

      if (widget.showIndexColumn) {
        cells.add(
          DataCell(
            Text(
              '$globalIdx',
              style: TextStyle(
                color: cfg.cellTextStyle?.color?.withValues(alpha: 0.5) ?? Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
        );
      }

      for (final col in widget.columns) {
        final val = row[col.key];
        final customCell = widget.cellBuilder?.call(context, localIdx, col.key, val);
        cells.add(
          DataCell(
            customCell ??
                Align(
                  alignment: col.alignment,
                  child: Text(
                    val != null ? '$val' : '—',
                    style: cfg.cellTextStyle ??
                        const TextStyle(
                          fontSize: 12,
                          color: Color(0xFFC9D1D9),
                        ),
                  ),
                ),
          ),
        );
      }

      return DataRow(
        color: WidgetStateProperty.all(rowColor),
        onSelectChanged: widget.onRowTap != null ? (_) => widget.onRowTap!(row) : null,
        cells: cells,
      );
    }).toList();
  }

  Widget _buildPaginationBar(TableDesignConfig cfg, int totalRows) {
    final start = _currentPage * widget.pageSize + 1;
    final end = ((_currentPage + 1) * widget.pageSize).clamp(1, totalRows);
    final totalPages = _totalPages;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: cfg.paginationBackgroundColor ?? cfg.headerBackgroundColor,
        border: Border(
          top: BorderSide(
            color: cfg.gridLineColor,
            width: cfg.gridLineWidth,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Showing $start–$end of $totalRows records',
            style: cfg.paginationTextStyle ??
                TextStyle(
                  fontSize: 12,
                  color: cfg.cellTextStyle?.color?.withValues(alpha: 0.7) ?? const Color(0xFF8B949E),
                ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left_rounded, size: 20),
                color: _currentPage > 0 ? (cfg.cellTextStyle?.color ?? Colors.white) : Colors.grey.withValues(alpha: 0.4),
                onPressed: _currentPage > 0
                    ? () => setState(() => _currentPage--)
                    : null,
                tooltip: 'Previous Page',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '${_currentPage + 1} / $totalPages',
                  style: cfg.paginationTextStyle ??
                      TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: cfg.cellTextStyle?.color ?? Colors.white,
                      ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right_rounded, size: 20),
                color: _currentPage < totalPages - 1
                    ? (cfg.cellTextStyle?.color ?? Colors.white)
                    : Colors.grey.withValues(alpha: 0.4),
                onPressed: _currentPage < totalPages - 1
                    ? () => setState(() => _currentPage++)
                    : null,
                tooltip: 'Next Page',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
