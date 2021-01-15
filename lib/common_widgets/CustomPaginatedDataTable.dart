// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;

import 'package:accountmanager/constants/color_defs.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;

import 'package:flutter/material.dart';

import 'CustomDataTable.dart';
import 'CustomDataTableSource.dart';

/// A material design data table that shows data using multiple pages.
///
/// A paginated data table shows [rowsPerPage] rows of data per page and
/// provides controls for showing other pages.
///
/// Data is read lazily from from a [DataTableSource]. The widget is presented
/// as a [Card].
///
/// See also:
///
///  * [DataTable], which is not paginated.
///  * <https://material.io/go/design-data-tables#data-tables-tables-within-cards>
class CustomPaginatedDataTable extends StatefulWidget {
  /// Creates a widget describing a paginated [DataTable] on a [Card].
  ///
  /// The [header] should give the card's header, typically a [Text] widget. It
  /// must not be null.
  ///
  /// The [columns] argument must be a list of as many [DataColumn] objects as
  /// the table is to have columns, ignoring the leading checkbox column if any.
  /// The [columns] argument must have a length greater than zero and cannot be
  /// null.
  ///
  /// If the table is sorted, the column that provides the current primary key
  /// should be specified by index in [sortColumnIndex], 0 meaning the first
  /// column in [columns], 1 being the next one, and so forth.
  ///
  /// The actual sort order can be specified using [sortAscending]; if the sort
  /// order is ascending, this should be true (the default), otherwise it should
  /// be false.
  ///
  /// The [source] must not be null. The [source] should be a long-lived
  /// [DataTableSource]. The same source should be provided each time a
  /// particular [CustomPaginatedDataTable] widget is created; avoid creating a new
  /// [DataTableSource] with each new instance of the [CustomPaginatedDataTable]
  /// widget unless the data table really is to now show entirely different
  /// data from a new source.
  ///
  /// The [rowsPerPage] and [availableRowsPerPage] must not be null (they
  /// both have defaults, though, so don't have to be specified).
  CustomPaginatedDataTable({
    Key key,
    this.header,
    this.actions,
    @required this.columns,
    this.sortColumnIndex,
    this.sortAscending = true,
    this.onSelectAll,
    this.dataRowHeight = kMinInteractiveDimension,
    this.headingRowHeight = 56.0,
    this.headingRowColor: Colors.red,
    this.horizontalMargin = 24.0,
    this.columnSpacing = 56.0,
    this.showCheckboxColumn = true,
    this.initialFirstRowIndex = 0,
    this.onPageChanged,
    this.rowsPerPage = defaultRowsPerPage,
    this.availableRowsPerPage = const <int>[
      defaultRowsPerPage,
      defaultRowsPerPage * 2,
      defaultRowsPerPage * 5,
      defaultRowsPerPage * 10,
      defaultRowsPerPage * 20,
      defaultRowsPerPage * 50,
      defaultRowsPerPage * 100,
      defaultRowsPerPage * 200,
      defaultRowsPerPage * 500,
      defaultRowsPerPage * 1000,
    ],
    this.onRowsPerPageChanged,
    this.dragStartBehavior = DragStartBehavior.start,
    @required this.source,
  })  : assert(columns != null),
        assert(dragStartBehavior != null),
        assert(columns.isNotEmpty),
        assert(sortColumnIndex == null ||
            (sortColumnIndex >= 0 && sortColumnIndex < columns.length)),
        assert(sortAscending != null),
        assert(dataRowHeight != null),
        assert(headingRowHeight != null),
        assert(horizontalMargin != null),
        assert(columnSpacing != null),
        assert(showCheckboxColumn != null),
        assert(rowsPerPage != null),
        assert(rowsPerPage > 0),
        assert(() {
          if (onRowsPerPageChanged != null)
            assert(availableRowsPerPage != null &&
                availableRowsPerPage.contains(rowsPerPage));
          return true;
        }()),
        assert(source != null),
        super(key: key);

  /// The table card's header.
  ///
  /// This is typically a [Text] widget, but can also be a [ButtonBar] with
  /// [FlatButton]s. Suitable defaults are automatically provided for the font,
  /// button color, button padding, and so forth.
  ///
  /// If items in the table are selectable, then, when the selection is not
  /// empty, the header is replaced by a count of the selected items.
  final Widget header;

  /// Icon buttons to show at the top right of the table.
  ///
  /// Typically, the exact actions included in this list will vary based on
  /// whether any rows are selected or not.
  ///
  /// These should be size 24.0 with default padding (8.0).
  final List<Widget> actions;

  /// The configuration and labels for the columns in the table.
  final List<CustomDataColumn> columns;

  /// The current primary sort key's column.
  ///
  /// See [DataTable.sortColumnIndex].
  final int sortColumnIndex;

  /// Whether the column mentioned in [sortColumnIndex], if any, is sorted
  /// in ascending order.
  ///
  /// See [DataTable.sortAscending].
  final bool sortAscending;

  /// Invoked when the user selects or unselects every row, using the
  /// checkbox in the heading row.
  ///
  /// See [DataTable.onSelectAll].
  final ValueSetter<bool> onSelectAll;

  /// The height of each row (excluding the row that contains column headings).
  ///
  /// This value is optional and defaults to kMinInteractiveDimension if not
  /// specified.
  final double dataRowHeight;

  /// The height of the heading row.
  ///
  /// This value is optional and defaults to 56.0 if not specified.
  final double headingRowHeight;
  final Color headingRowColor;

  /// The horizontal margin between the edges of the table and the content
  /// in the first and last cells of each row.
  ///
  /// When a checkbox is displayed, it is also the margin between the checkbox
  /// the content in the first data column.
  ///
  /// This value defaults to 24.0 to adhere to the Material Design specifications.
  final double horizontalMargin;

  /// The horizontal margin between the contents of each data column.
  ///
  /// This value defaults to 56.0 to adhere to the Material Design specifications.
  final double columnSpacing;

  /// {@macro flutter.material.dataTable.showCheckboxColumn}
  final bool showCheckboxColumn;

  /// The index of the first row to display when the widget is first created.
  final int initialFirstRowIndex;

  /// Invoked when the user switches to another page.
  ///
  /// The value is the index of the first row on the currently displayed page.
  final ValueChanged<int> onPageChanged;

  /// The number of rows to show on each page.
  ///
  /// See also:
  ///
  ///  * [onRowsPerPageChanged]
  ///  * [defaultRowsPerPage]
  final int rowsPerPage;

  /// The default value for [rowsPerPage].
  ///
  /// Useful when initializing the field that will hold the current
  /// [rowsPerPage], when implemented [onRowsPerPageChanged].
  static const int defaultRowsPerPage = 14;

  /// The options to offer for the rowsPerPage.
  ///
  /// The current [rowsPerPage] must be a value in this list.
  ///
  /// The values in this list should be sorted in ascending order.
  final List<int> availableRowsPerPage;

  /// Invoked when the user selects a different number of rows per page.
  ///
  /// If this is null, then the value given by [rowsPerPage] will be used
  /// and no affordance will be provided to change the value.
  final ValueChanged<int> onRowsPerPageChanged;

  /// The data source which provides data to show in each row. Must be non-null.
  ///
  /// This object should generally have a lifetime longer than the
  /// [CustomPaginatedDataTable] widget itself; it should be reused each time the
  /// [CustomPaginatedDataTable] constructor is called.
  final CustomDataTableSource source;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  @override
  CustomPaginatedDataTableState createState() =>
      CustomPaginatedDataTableState();
}

/// Holds the state of a [CustomPaginatedDataTable].
///
/// The table can be programmatically paged using the [pageTo] method.
class CustomPaginatedDataTableState extends State<CustomPaginatedDataTable> {
  int _firstRowIndex;
  int _rowCount;
  bool _rowCountApproximate;
  // int _selectedRowCount;
  final Map<int, CustomDataRow> _rows = <int, CustomDataRow>{};

  @override
  void initState() {
    super.initState();
    _firstRowIndex = PageStorage.of(context)?.readState(context) as int ??
        widget.initialFirstRowIndex ??
        0;
    widget.source.addListener(_handleDataSourceChanged);
    _handleDataSourceChanged();
  }

  @override
  void didUpdateWidget(CustomPaginatedDataTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.source != widget.source) {
      oldWidget.source.removeListener(_handleDataSourceChanged);
      widget.source.addListener(_handleDataSourceChanged);
      _handleDataSourceChanged();
    }
  }

  @override
  void dispose() {
    widget.source.removeListener(_handleDataSourceChanged);
    super.dispose();
  }

  void _handleDataSourceChanged() {
    setState(() {
      _rowCount = widget.source.rowCount;
      _rowCountApproximate = widget.source.isRowCountApproximate;
      _rows.clear();
    });
  }

  /// Ensures that the given row is visible.
  void pageTo(int rowIndex) {
    final int oldFirstRowIndex = _firstRowIndex;
    setState(() {
      final int rowsPerPage = widget.rowsPerPage;
      _firstRowIndex = (rowIndex ~/ rowsPerPage) * rowsPerPage;
    });
    if ((widget.onPageChanged != null) && (oldFirstRowIndex != _firstRowIndex))
      widget.onPageChanged(_firstRowIndex);
  }

  CustomDataRow _getBlankRowFor(int index) {
    return CustomDataRow.byIndex(
      index: index,
      cells: widget.columns
          .map<CustomDataCell>(
              (CustomDataColumn column) => CustomDataCell.empty)
          .toList(),
    );
  }

  CustomDataRow _getProgressIndicatorRowFor(int index) {
    bool haveProgressIndicator = false;
    final List<CustomDataCell> cells =
        widget.columns.map<CustomDataCell>((CustomDataColumn column) {
      if (!column.numeric) {
        haveProgressIndicator = true;
        return const CustomDataCell(CircularProgressIndicator());
      }
      return CustomDataCell.empty;
    }).toList();
    if (!haveProgressIndicator) {
      haveProgressIndicator = true;
      cells[0] = const CustomDataCell(CircularProgressIndicator());
    }
    return CustomDataRow.byIndex(
      index: index,
      cells: cells,
    );
  }

  List<CustomDataRow> _getRows(int firstRowIndex, int rowsPerPage) {
    final List<CustomDataRow> result = <CustomDataRow>[];
    final int nextPageFirstRowIndex = firstRowIndex + rowsPerPage;
    bool haveProgressIndicator = false;
    for (int index = firstRowIndex; index < nextPageFirstRowIndex; index += 1) {
      if (index < _rowCount) {
        // <---
        // This stops "overflow" rows from appearing on the last page.
        CustomDataRow row;
        if (index < _rowCount || _rowCountApproximate) {
          row = _rows.putIfAbsent(index, () => widget.source.getRow(index));
          if (row == null && !haveProgressIndicator) {
            row ??= _getProgressIndicatorRowFor(index);
            haveProgressIndicator = true;
          }
        }
        row ??= _getBlankRowFor(index);
        result.add(row);
      } // <---
    }
    return result;
  }

  void _handlePrevious() {
    pageTo(math.max(_firstRowIndex - widget.rowsPerPage, 0));
  }

  void _handleNext() {
    pageTo(_firstRowIndex + widget.rowsPerPage);
  }

  final GlobalKey _tableKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // (ianh): This whole build function doesn't handle RTL yet.
    assert(debugCheckHasMaterialLocalizations(context));
    final ThemeData themeData = Theme.of(context);
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    // HEADER
    final List<Widget> headerWidgets = <Widget>[];
    if (widget.actions != null) {
      headerWidgets.addAll(widget.actions.map<Widget>((Widget action) {
        return Padding(
          // 8.0 is the default padding of an icon button
          padding: const EdgeInsetsDirectional.only(start: 24.0 - 8.0 * 2.0),
          child: action,
        );
      }).toList());
    }

    // FOOTER
    final TextStyle footerTextStyle = themeData.textTheme.caption;
    final List<Widget> footerWidgets = <Widget>[];
    if (widget.onRowsPerPageChanged != null) {
      final List<Widget> availableRowsPerPage = widget.availableRowsPerPage
          .where(
              (int value) => value <= _rowCount || value == widget.rowsPerPage)
          .map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text('$value', style: ColorDefs.textBodyBlue10),
        );
      }).toList();
      footerWidgets.addAll(<Widget>[
        Container(
            width:
                14.0), // to match trailing padding in case we overflow and end up scrolling
        Text(localizations.rowsPerPageTitle, style: ColorDefs.textBodyBlue10),
        ConstrainedBox(
          constraints: const BoxConstraints(
              minWidth: 64.0), // 40.0 for the text, 24.0 for the icon
          child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                items: availableRowsPerPage.cast<DropdownMenuItem<int>>(),
                value: widget.rowsPerPage,
                onChanged: widget.onRowsPerPageChanged,
                style: footerTextStyle,
                iconSize: 24.0,
              ),
            ),
          ),
        ),
      ]);
    }
    footerWidgets.addAll(<Widget>[
      Container(width: 32.0),
      Text(
          localizations.pageRowsInfoTitle(
            _firstRowIndex + 1,
            (_firstRowIndex + widget.rowsPerPage <= _rowCount)
                ? _firstRowIndex + widget.rowsPerPage
                : _rowCount,
            _rowCount,
            _rowCountApproximate,
          ),
          style: ColorDefs.textBodyBronze20),
      Container(width: 32.0),
      IconButton(
        icon: const Icon(Icons.chevron_left),
        padding: EdgeInsets.zero,
        tooltip: localizations.previousPageTooltip,
        onPressed: _firstRowIndex <= 0 ? null : _handlePrevious,
      ),
      Container(width: 24.0),
      IconButton(
        icon: const Icon(Icons.chevron_right),
        padding: EdgeInsets.zero,
        tooltip: localizations.nextPageTooltip,
        onPressed: (!_rowCountApproximate &&
                (_firstRowIndex + widget.rowsPerPage >= _rowCount))
            ? null
            : _handleNext,
      ),
      Container(width: 14.0),
    ]);

    // CARD
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Card(
          semanticContainer: false,
          color: ColorDefs.colorDarkest,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                dragStartBehavior: widget.dragStartBehavior,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.minWidth),
                  child: Container(
                    color: ColorDefs.colorDarkest,
                    child: CustomDataTable(
                      showCheckboxColumn: widget.showCheckboxColumn,
                      key: _tableKey,
                      columns: widget.columns,
                      sortColumnIndex: widget.sortColumnIndex,
                      sortAscending: widget.sortAscending,
                      onSelectAll: widget.onSelectAll,
                      dataRowHeight: widget.dataRowHeight,
                      headingRowHeight: widget.headingRowHeight,
                      headingRowColor: widget.headingRowColor,
                      horizontalMargin: widget.horizontalMargin,
                      columnSpacing: widget.columnSpacing,
                      rows: _getRows(_firstRowIndex, widget.rowsPerPage),
                    ),
                  ),
                ),
              ),
              DefaultTextStyle(
                style: footerTextStyle,
                child: IconTheme.merge(
                  data: const IconThemeData(opacity: 0.54),
                  child: Container(
                    color: Colors.blue,
                    // (bkonyi): this won't handle text zoom correctly, https://github.com/flutter/flutter/issues/48522
                    height: 56.0,
                    child: SingleChildScrollView(
                      dragStartBehavior: widget.dragStartBehavior,
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      child: Container(
                        color: ColorDefs.colorDarkest,
                        child: Row(
                          children: footerWidgets,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
