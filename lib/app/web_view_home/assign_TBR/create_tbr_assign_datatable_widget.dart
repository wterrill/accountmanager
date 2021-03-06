import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/common_widgets/CustomDataTable.dart';
import 'package:accountmanager/common_widgets/CustomDataTableSource.dart';
import 'package:accountmanager/common_widgets/CustomPaginatedDataTable.dart';
import 'package:accountmanager/common_widgets/status_box.dart';
import 'package:accountmanager/constants/strings.dart';
import 'package:accountmanager/app/web_view_home/assign_TBR/widget_assign_TBR_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pedantic/pedantic.dart';
import 'package:accountmanager/models/assigned_tbr.dart';
import 'package:accountmanager/common_widgets/empty_content.dart';
import 'package:accountmanager/packages/alert_dialogs/alert_dialogs.dart';

// typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

final AutoDisposeStreamProvider<List<AssignedTBR>>? assignedTbrStreamProvider =
    StreamProvider.autoDispose<List<AssignedTBR>>((ref) {
  final database = ref.watch(databaseProvider);
  return database?.assignedTbrStream() ?? const Stream.empty();
});

class CreateTBRAssignDataTableWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final assignedTbrAsyncValue = watch(assignedTbrStreamProvider!);
    return DataTableBuilder(data: assignedTbrAsyncValue);
  }
}

class DataTableBuilder extends StatefulWidget {
  const DataTableBuilder({Key? key, required this.data}) : super(key: key);
  final AsyncValue<List<AssignedTBR>> data;

  @override
  _DataTableBuilderState createState() => _DataTableBuilderState();
}

// class name extends StatefulWidget {
//   name({Key key}) : super(key: key);

//   @override
//   _nameState createState() => _nameState();
// }

// class _nameState extends State<name> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//        child: child,
//     );
//   }
// }

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
            CustomPaginatedDataTable(
              headingRowColor: Colors.grey[300],
              showCheckboxColumn: false,
              header: Text(Strings.tbrStrings.header),
              source: dtsSource,
              rowsPerPage: _rowsPerPage,
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _sortAscending,
              onRowsPerPageChanged: (rows) {
                setState(() {
                  _rowsPerPage = rows!;
                });
              },
              columns: [
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
                        getField: (d) =>
                            "TODO", //TODO this needs to be the firstName of the tech looked up.  //d.technician!.firstName,
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
                  // label: Text('CreateTBRAssignDataTableWidget'),
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
                  label: Text(Strings.tbrStrings.type),
                  onSort: (columnIndex, ascending) {
                    dtsSource.sort<String>(
                        getField: (d) => d.questionnaireType!.name,
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
            Container(height: 150),
          ],
        ),
      ),
    );
  }
}

class DTS extends CustomDataTableSource {
  final List<AssignedTBR> data;
  final BuildContext context;

  DTS(
    this.data,
    this.context,
  );

  @override
  CustomDataRow getRow(int index) {
    // print(data);
    // print(data[index]);
    // print(index);
    if (index < data.length) {
      return CustomDataRow(
          onSelectChanged: (_) {
            if (data[index].status.getStatusName() != 'Completed') {
              _displayDialog(context, data[index]);
            } else {
              print(
                  'nope'); // Todo This should be a dialog at least... at most it should show the completed (and now editable) TBR
            }
          },
          cells: [
            CustomDataCell(statusBox(data[index].status.getStatusName())),
            CustomDataCell(Text(data[index].company.toDropDownString()!)),
            CustomDataCell(Text(
                "TODO")), //TODO this was from the dropdownList  Text(data[index].technicianIds.toDropDownString())),
            CustomDataCell(
                Text(DateFormat.yMMMEd().format(data[index].dueDate))),
            CustomDataCell(Text(
                DateFormat.yMMMEd().format(data[index].clientMeetingDate))),
            CustomDataCell(Text(data[index].questionnaireType!.name)),
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
      {Comparable<T>? Function(AssignedTBR d)? getField, bool? ascending}) {
    data.sort((a, b) {
      if (!ascending!) {
        final AssignedTBR c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField!(a)!;
      final Comparable<T> bValue = getField(b)!;
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
  try {
    final Map<String, dynamic>? result = await showWidgetDialog(
      context: context,
      title: '',
      widget: AssignTBR(data: data),
      defaultActionText: '',
      cancelActionText: '',
    );

    if (result != null && (result['result']) == 'true') {
      // print('result = $result');
    }
  } catch (e) {
    unawaited(showExceptionAlertDialog(
      context: context,
      title: 'Operation failed',
      exception: e,
    ));
  }
}
