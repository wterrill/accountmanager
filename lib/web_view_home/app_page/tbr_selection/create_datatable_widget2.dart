import 'package:accountmanager/app/home/app_page/tbr/tbr_entry.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/constants/strings.dart';
import 'package:accountmanager/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:intl/intl.dart';
import 'package:pedantic/pedantic.dart';

// import 'package:accountmanager/app/home/assign_TBR/widget_assign_TBR2.dart';
import 'package:accountmanager/app/home/models/assignedTbr.dart';
import 'package:accountmanager/common_widgets/empty_content.dart';
import 'package:accountmanager/packages/alert_dialogs/alert_dialogs.dart';

// typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

final assignedTbrStreamProvider =
    StreamProvider.autoDispose<List<AssignedTBR>>((ref) {
  final database = ref.watch(databaseProvider);
  return database?.assignedTbrStream() ?? const Stream.empty();
});

class CreateSelectDataTableWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final assignedTbrAsyncValue = watch(assignedTbrStreamProvider);
    return DataTableBuilder(data: assignedTbrAsyncValue);
  }
}

class DataTableBuilder extends StatefulWidget {
  const DataTableBuilder({Key key, @required this.data}) : super(key: key);
  final AsyncValue<List<AssignedTBR>> data;

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
          ? _datatable(DTS(items, context))
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
            PaginatedDataTable(
              showCheckboxColumn: false,
              header: Text("Select TBR to be completed"),
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
                DataColumn(
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
                DataColumn(
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
                DataColumn(
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
                DataColumn(
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
                DataColumn(
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
                DataColumn(
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
                DataColumn(
                  label: Text('Assigned By'),
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
            Container(height: 150),
          ],
        ),
      ),
    );
  }
}

class DTS extends DataTableSource {
  final List<AssignedTBR> data;
  final BuildContext context;

  DTS(
    this.data,
    this.context,
  );

  @override
  DataRow getRow(int index) {
    // print(data);
    // print(data[index]);
    // print(index);
    if (index < data.length) {
      return DataRow(
          onSelectChanged: (_) {
            _displayDialog(context, data[index]);
          },
          cells: [
            // ignore: unnecessary_string_interpolations
            DataCell(Text('${data[index].company.toDropDownString()}')),
            // ignore: unnecessary_string_interpolations
            DataCell(Text('${data[index].technician.toDropDownString()}')),
            DataCell(Text(DateFormat.yMMMEd().format(data[index].dueDate))),
            DataCell(Text(
                DateFormat.yMMMEd().format(data[index].clientMeetingDate))),
            DataCell(Text(data[index].status.getStatusName())),
            DataCell(Text(data[index].questionnaireType.name)),
            DataCell(Text(data[index].assignedBy))
          ]);
    } else {
      return const DataRow(cells: [
        DataCell(Text(Strings.placeHolder)),
        DataCell(Text(Strings.placeHolder)),
        DataCell(Text(Strings.placeHolder)),
        DataCell(Text(Strings.placeHolder)),
        DataCell(Text(Strings.placeHolder)),
        DataCell(Text(Strings.placeHolder)),
        DataCell(Text(Strings.placeHolder)),
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

Future<void> _displayDialog(BuildContext context, AssignedTBR data) async {
  print('_displayDialog => $data');

// This gets rid of tabs
  // await Navigator.of(context, rootNavigator: true).pushNamed(
  //   AppRoutes.tbrPage,
  //   arguments: {
  //     'data': data,
  //   },
  // );

  // this keeps the tab bar
  await Navigator.of(context).push<TBREntry>(
      MaterialPageRoute(builder: (context) => TBREntry(data: data)));

// this keeps the tab bar
  // await Navigator.of(context).pushAndRemoveUntil<TBREntry>(
  //   MaterialPageRoute(builder: (context) => TBREntry(data: data)),
  //   ModalRoute.withName('/'),
  // );

  // await Navigator.of(context).pushAndRemoveUntil<TBREntry>(
  //     MaterialPageRoute(builder: (context) => TBREntry(data: data)),
  //     (Route<dynamic> route) => false);

  // Navigator.of(context).pushNamed('/tbrPage');

  // try {
  //   final Map<String, dynamic> result = await showWidgetDialog(
  //     context: context,
  //     title: 'Assign TBR',
  //     widget:
  //     // defaultActionText: '',
  //     // cancelActionText: '',
  //   );

  //   if (result != null && (result['result']) == 'true') {
  //     // print('result = $result');
  //   }
  // } catch (e) {
  //   unawaited(showExceptionAlertDialog(
  //     context: context,
  //     title: 'Operation failed',
  //     exception: e,
  //   ));
  // }
}