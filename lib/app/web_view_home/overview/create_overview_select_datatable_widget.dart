import 'package:accountmanager/app/web_view_home/home/sidebar/sidebar.dart';
import 'package:accountmanager/app/web_view_home/overview/overview_paginated_table.dart';
import 'package:accountmanager/app/web_view_home/overview/tbr_app_page.dart';
import 'package:accountmanager/common_widgets/CustomDataTable.dart';
import 'package:accountmanager/common_widgets/CustomDataTableSource.dart';
import 'package:accountmanager/common_widgets/CustomPaginatedDataTable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:intl/intl.dart';

import 'package:accountmanager/models/assigned_tbr.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/common_widgets/empty_content.dart';
import 'package:accountmanager/constants/strings.dart';

final assignedTbrStreamProvider =
    StreamProvider.autoDispose<List<AssignedTBR>>((ref) {
  final database = ref.watch(databaseProvider);
  return database?.assignedTbrStream() ?? const Stream.empty();
});

class CreateOverviewSelectDataTableWidget extends ConsumerWidget {
  final bool mobile;
  final double scale;

  const CreateOverviewSelectDataTableWidget({
    this.mobile,
    this.scale,
  });
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final assignedTbrAsyncValue = watch(assignedTbrStreamProvider);
    final questionsAsync = watch(questionStreamProvider);
    questionsAsync.whenData((questions) {
      watch(latestQuestionsProvider).state = questions;
    });

    return DataTableBuilder(data: assignedTbrAsyncValue, mobile: mobile);
  }
}

class DataTableBuilder extends StatefulWidget {
  const DataTableBuilder({
    Key key,
    this.data,
    @required this.mobile,
  }) : super(key: key);
  final AsyncValue<List<AssignedTBR>> data;
  final bool mobile;

  @override
  _DataTableBuilderState createState() => _DataTableBuilderState();
}

class _DataTableBuilderState extends State<DataTableBuilder> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex = 0;
  bool _sortAscending = false;

  @override
  void initState() {
    _sortAscending = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.data.when(
      data: (items) => items.isNotEmpty
          ? _datatable(
              DTS(incomingData: items, context: context, mobile: widget.mobile))
          : const EmptyContent(),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const EmptyContent(
        title: 'Something went wrong',
        message: 'Can\'t load items right now',
      ),
    );
  }

  Widget _datatable(DTS dtsSource) {
    return Flexible(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DefaultTextStyle(
              style: const TextStyle(fontSize: 10, color: Colors.blue),
              child: CustomPaginatedDataTable(
                headingRowColor: Colors.grey[300],
                showCheckboxColumn: false,
                header: const Text('Select TBR to be completed'),
                source: dtsSource,
                rowsPerPage: _rowsPerPage,
                sortColumnIndex: _sortColumnIndex,
                sortAscending: _sortAscending,
                onRowsPerPageChanged: (rows) {
                  setState(() {
                    _rowsPerPage = rows;
                  });
                },
                columns: [
                  CustomDataColumn(
                    label: Text(Strings.companyStrings.company),
                    onSort: (columnIndex, ascending) {
                      dtsSource.sort<String>(
                          getField: (d) => d.company.name,
                          ascending: _sortAscending);
                      setState(() {
                        _sortColumnIndex = columnIndex;
                        _sortAscending = !_sortAscending;
                      });
                    },
                  ),
                  CustomDataColumn(
                    label: Text(Strings.technicianStrings.technician),
                    onSort: (columnIndex, ascending) {
                      dtsSource.sort<String>(
                          getField: (d) => d.technician.name,
                          ascending: _sortAscending);
                      setState(() {
                        _sortColumnIndex = columnIndex;
                        _sortAscending = !_sortAscending;
                      });
                    },
                  ),
                  CustomDataColumn(
                    label: Text(Strings.tbrStrings.dueDate),
                    onSort: (columnIndex, ascending) {
                      dtsSource.sort<String>(
                          getField: (d) => d.dueDate.toString(),
                          ascending: _sortAscending);
                      setState(() {
                        _sortColumnIndex = columnIndex;
                        _sortAscending = !_sortAscending;
                      });
                    },
                  ),
                  CustomDataColumn(
                    label: Text(Strings.tbrStrings.meetingDate),
                    onSort: (columnIndex, ascending) {
                      dtsSource.sort<String>(
                          getField: (d) => d.clientMeetingDate.toString(),
                          ascending: _sortAscending);
                      setState(() {
                        _sortColumnIndex = columnIndex;
                        _sortAscending = !_sortAscending;
                      });
                    },
                  ),
                  CustomDataColumn(
                    label: Text(Strings.tbrStrings.status),
                    onSort: (columnIndex, ascending) {
                      dtsSource.sort<String>(
                          getField: (d) => d.status.statusIndex.toString(),
                          ascending: _sortAscending);
                      setState(() {
                        _sortColumnIndex = columnIndex;
                        _sortAscending = !_sortAscending;
                      });
                    },
                  ),
                  CustomDataColumn(
                    label: Text(Strings.tbrStrings.type),
                    onSort: (columnIndex, ascending) {
                      dtsSource.sort<String>(
                          getField: (d) => d.questionnaireType.name,
                          ascending: _sortAscending);
                      setState(() {
                        _sortColumnIndex = columnIndex;
                        _sortAscending = !_sortAscending;
                      });
                    },
                  ),
                  CustomDataColumn(
                    label: const Text('Assigned By'),
                    onSort: (columnIndex, ascending) {
                      dtsSource.sort<String>(
                          getField: (d) => d.assignedBy,
                          ascending: _sortAscending);
                      setState(() {
                        _sortColumnIndex = columnIndex;
                        _sortAscending = !_sortAscending;
                      });
                    },
                  )
                ],
              ),
            ),
            Container(height: 150),
          ],
        ),
      ),
    );
  }
}

class DTS extends CustomDataTableSource {
  final List<AssignedTBR> incomingData;
  List<AssignedTBR> data;
  final BuildContext context;
  final bool mobile;

  DTS({this.incomingData, this.context, this.mobile}) {
    filterValues(context);
  }

  void filterValues(BuildContext context) {
    // final bool showAll = context.read(showAllSwitchProvider).state;
    const bool showAll = false;
    if (showAll) {
      data = incomingData;
    } else {
      data = incomingData
          .where((element) => element.status.getStatusName() == 'Completed')
          .toList();
    }
  }

  @override
  CustomDataRow getRow(int index) {
    if (index < data.length) {
      return CustomDataRow(
          onSelectChanged: (_) {
            _displayNextPage(
                context: context, assignedTBR: data[index], mobile: mobile);
          },
          cells: [
            // ignore: unnecessary_string_interpolations
            CustomDataCell(Text('${data[index].company.toDropDownString()}')),
            CustomDataCell(
                // ignore: unnecessary_string_interpolations
                Text('${data[index].technician.toDropDownString()}')),
            CustomDataCell(
                Text(DateFormat.yMMMEd().format(data[index].dueDate))),
            CustomDataCell(Text(
                DateFormat.yMMMEd().format(data[index].clientMeetingDate))),
            CustomDataCell(Text(data[index].status.getStatusName())),
            CustomDataCell(Text(data[index].questionnaireType.name)),
            CustomDataCell(Text(data[index].assignedBy))
          ]);
    } else {
      return const CustomDataRow(cells: [
        CustomDataCell(Text(Strings.placeHolder)),
        CustomDataCell(Text(Strings.placeHolder)),
        CustomDataCell(Text(Strings.placeHolder)),
        CustomDataCell(Text(Strings.placeHolder)),
        CustomDataCell(Text(Strings.placeHolder)),
        CustomDataCell(Text(Strings.placeHolder)),
        CustomDataCell(Text(Strings.placeHolder)),
      ]);
    }
  }

  void sort<T>(
      {Comparable<T> Function(AssignedTBR d) getField, bool ascending}) {
    data.sort((a, b) {
      if (!ascending) {
        final AssignedTBR c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    // notifyListeners();
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

Future<void> _displayNextPage(
    {BuildContext context, AssignedTBR assignedTBR, bool mobile}) async {
  print(
      'onPressed in _displayDialog in create_overview_select_datatable_widget.dart');
  final String id = assignedTBR.id;
  print('id');
  // ignore: prefer_const_constructors
  Widget frame = Text('error');
  if (assignedTBR.status.getStatusName() == 'Assigned') {
    context.read(currentAssignedTbrProvider).state = assignedTBR;
    frame = TBRappPage(assignedTBR: assignedTBR);
  } else {
    frame = Container(
      alignment: Alignment.topCenter,
      color: Colors.white,
      child: SingleChildScrollView(
        // scrollDirection: Axis.horizontal,
        child: OverviewPaginatedTable(id: id),
      ),
    );

    // );
  }
  // Widget frame =
  //     Container(color: Colors.brown[150], child: TBRappPage(data: data));
  if (mobile) {
    frame = Expanded(
      child: Center(child: addMobileFrame(frame)),
    );
  } else {
    frame = Expanded(child: Center(child: frame));
  }
  print('_displayDialog => $assignedTBR');
  context.read(widgetProvider).state = frame;
}
