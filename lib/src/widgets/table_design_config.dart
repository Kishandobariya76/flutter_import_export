import 'package:flutter/material.dart';

/// Configuration class for customizing data table appearance,
/// including borders, colors, header styles, alternating row colors,
/// and cell padding.
class TableDesignConfig {
  /// Background color of the header row.
  final Color headerBackgroundColor;

  /// Text style for header labels.
  final TextStyle? headerTextStyle;

  /// Height of the header row in logical pixels.
  final double headerHeight;

  /// Background color for even rows.
  final Color rowBackgroundColor;

  /// Background color for odd rows (when zebra striping is enabled).
  final Color? alternateRowBackgroundColor;

  /// Background color when a row is hovered or selected.
  final Color? rowHoverColor;

  /// Text style for table cells.
  final TextStyle? cellTextStyle;

  /// Outer border color of the table container.
  final Color borderColor;

  /// Outer border width of the table container.
  final double borderWidth;

  /// Corner radius of the table.
  final BorderRadius borderRadius;

  /// Whether to display vertical grid divider lines between columns.
  final bool showVerticalGridLines;

  /// Whether to display horizontal divider lines between rows.
  final bool showHorizontalGridLines;

  /// Color of the grid dividers.
  final Color gridLineColor;

  /// Width of the grid dividers.
  final double gridLineWidth;

  /// Padding inside each cell.
  final EdgeInsetsGeometry cellPadding;

  /// Horizontal spacing between columns.
  final double columnSpacing;

  /// Height of data rows.
  final double? rowHeight;

  /// Background color for the pagination bar.
  final Color? paginationBackgroundColor;

  /// Text style for pagination labels.
  final TextStyle? paginationTextStyle;

  const TableDesignConfig({
    this.headerBackgroundColor = const Color(0xFF161B22),
    this.headerTextStyle,
    this.headerHeight = 48.0,
    this.rowBackgroundColor = const Color(0xFF0D1117),
    this.alternateRowBackgroundColor = const Color(0xFF161B22),
    this.rowHoverColor = const Color(0xFF21262D),
    this.cellTextStyle,
    this.borderColor = const Color(0xFF30363D),
    this.borderWidth = 1.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(10.0)),
    this.showVerticalGridLines = false,
    this.showHorizontalGridLines = true,
    this.gridLineColor = const Color(0xFF21262D),
    this.gridLineWidth = 1.0,
    this.cellPadding = const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
    this.columnSpacing = 24.0,
    this.rowHeight = 48.0,
    this.paginationBackgroundColor,
    this.paginationTextStyle,
  });

  /// Modern dark theme (Vercel / GitHub Dark style).
  factory TableDesignConfig.dark() {
    return const TableDesignConfig(
      headerBackgroundColor: Color(0xFF161B22),
      headerTextStyle: TextStyle(color: Color(0xFFE6EDF3), fontWeight: FontWeight.bold, fontSize: 12),
      rowBackgroundColor: Color(0xFF0D1117),
      alternateRowBackgroundColor: Color(0xFF13171F),
      rowHoverColor: Color(0xFF1F242C),
      cellTextStyle: TextStyle(color: Color(0xFF8B949E), fontSize: 13),
      borderColor: Color(0xFF30363D),
      borderWidth: 1.0,
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      showVerticalGridLines: false,
      showHorizontalGridLines: true,
      gridLineColor: Color(0xFF21262D),
    );
  }

  /// Clean modern light theme for enterprise apps.
  factory TableDesignConfig.light() {
    return const TableDesignConfig(
      headerBackgroundColor: Color(0xFFF6F8FA),
      headerTextStyle: TextStyle(color: Color(0xFF1F2328), fontWeight: FontWeight.bold, fontSize: 12),
      rowBackgroundColor: Colors.white,
      alternateRowBackgroundColor: Color(0xFFF9FAFB),
      rowHoverColor: Color(0xFFEEF2F6),
      cellTextStyle: TextStyle(color: Color(0xFF24292F), fontSize: 13),
      borderColor: Color(0xFFD0D7DE),
      borderWidth: 1.0,
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      showVerticalGridLines: false,
      showHorizontalGridLines: true,
      gridLineColor: Color(0xFFE1E4E8),
    );
  }

  /// Ocean Navy enterprise theme with vibrant blue accents.
  factory TableDesignConfig.oceanNavy() {
    return const TableDesignConfig(
      headerBackgroundColor: Color(0xFF0F1E36),
      headerTextStyle: TextStyle(color: Color(0xFF58A6FF), fontWeight: FontWeight.bold, fontSize: 12),
      rowBackgroundColor: Color(0xFF0A1324),
      alternateRowBackgroundColor: Color(0xFF0E1A30),
      rowHoverColor: Color(0xFF162544),
      cellTextStyle: TextStyle(color: Color(0xFFC9D1D9), fontSize: 13),
      borderColor: Color(0xFF1E3A66),
      borderWidth: 1.5,
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      showVerticalGridLines: true,
      showHorizontalGridLines: true,
      gridLineColor: Color(0xFF172B4D),
    );
  }

  /// Emerald Fintech theme with clean borders and high contrast.
  factory TableDesignConfig.emerald() {
    return const TableDesignConfig(
      headerBackgroundColor: Color(0xFF0D2818),
      headerTextStyle: TextStyle(color: Color(0xFF2EA043), fontWeight: FontWeight.bold, fontSize: 12),
      rowBackgroundColor: Color(0xFF07140C),
      alternateRowBackgroundColor: Color(0xFF0B1F13),
      rowHoverColor: Color(0xFF133621),
      cellTextStyle: TextStyle(color: Color(0xFFD2F5D7), fontSize: 13),
      borderColor: Color(0xFF238636),
      borderWidth: 1.5,
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      showVerticalGridLines: false,
      showHorizontalGridLines: true,
      gridLineColor: Color(0xFF1A4726),
    );
  }

  /// Minimal Bordered theme with crisp lines and no alternating background.
  factory TableDesignConfig.minimalBordered({Color borderColor = const Color(0xFF388BFD)}) {
    return TableDesignConfig(
      headerBackgroundColor: Colors.transparent,
      headerTextStyle: TextStyle(color: borderColor, fontWeight: FontWeight.bold, fontSize: 12),
      rowBackgroundColor: Colors.transparent,
      alternateRowBackgroundColor: null,
      rowHoverColor: borderColor.withValues(alpha: 0.1),
      cellTextStyle: const TextStyle(color: Color(0xFFE6EDF3), fontSize: 13),
      borderColor: borderColor,
      borderWidth: 2.0,
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      showVerticalGridLines: true,
      showHorizontalGridLines: true,
      gridLineColor: borderColor.withValues(alpha: 0.3),
    );
  }

  /// Creates a copy of this configuration with given fields replaced.
  TableDesignConfig copyWith({
    Color? headerBackgroundColor,
    TextStyle? headerTextStyle,
    double? headerHeight,
    Color? rowBackgroundColor,
    Color? alternateRowBackgroundColor,
    Color? rowHoverColor,
    TextStyle? cellTextStyle,
    Color? borderColor,
    double? borderWidth,
    BorderRadius? borderRadius,
    bool? showVerticalGridLines,
    bool? showHorizontalGridLines,
    Color? gridLineColor,
    double? gridLineWidth,
    EdgeInsetsGeometry? cellPadding,
    double? columnSpacing,
    double? rowHeight,
    Color? paginationBackgroundColor,
    TextStyle? paginationTextStyle,
  }) {
    return TableDesignConfig(
      headerBackgroundColor: headerBackgroundColor ?? this.headerBackgroundColor,
      headerTextStyle: headerTextStyle ?? this.headerTextStyle,
      headerHeight: headerHeight ?? this.headerHeight,
      rowBackgroundColor: rowBackgroundColor ?? this.rowBackgroundColor,
      alternateRowBackgroundColor: alternateRowBackgroundColor ?? this.alternateRowBackgroundColor,
      rowHoverColor: rowHoverColor ?? this.rowHoverColor,
      cellTextStyle: cellTextStyle ?? this.cellTextStyle,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      showVerticalGridLines: showVerticalGridLines ?? this.showVerticalGridLines,
      showHorizontalGridLines: showHorizontalGridLines ?? this.showHorizontalGridLines,
      gridLineColor: gridLineColor ?? this.gridLineColor,
      gridLineWidth: gridLineWidth ?? this.gridLineWidth,
      cellPadding: cellPadding ?? this.cellPadding,
      columnSpacing: columnSpacing ?? this.columnSpacing,
      rowHeight: rowHeight ?? this.rowHeight,
      paginationBackgroundColor: paginationBackgroundColor ?? this.paginationBackgroundColor,
      paginationTextStyle: paginationTextStyle ?? this.paginationTextStyle,
    );
  }
}
