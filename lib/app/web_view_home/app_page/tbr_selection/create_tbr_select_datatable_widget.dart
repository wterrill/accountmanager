import 'package:accountmanager/app/web_view_home/app_page/tbr_selection/start_tbr.dart';
import 'package:accountmanager/common_widgets/CustomDataTable.dart';
import 'package:accountmanager/common_widgets/CustomDataTableSource.dart';
import 'package:accountmanager/common_widgets/CustomPaginatedDataTable.dart';
import 'package:accountmanager/common_widgets/status_box.dart';
import 'package:accountmanager/models/tbr.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:accountmanager/models/assigned_tbr.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/common_widgets/empty_content.dart';
import 'package:accountmanager/constants/strings.dart';
import 'package:accountmanager/app/web_view_home/app_page/tbr/tbr_app_page.dart';
import 'package:accountmanager/app/web_view_home/home/sidebar/sidebar.dart';

final assignedTbrStreamProvider =
    StreamProvider.autoDispose<List<AssignedTBR>>((ref) {
  final database = ref.watch(databaseProvider);
  return database?.assignedTbrStream() ?? const Stream.empty();
});

class TableVars {
  TableVars(this.rowsPerPage) {
    sortColumnIndex = 0;
    sortAscending = true;
  }
  int rowsPerPage;
  int sortColumnIndex;
  bool sortAscending;
}

final tableVarsProvider = StateProvider<TableVars>(
    (ref) => TableVars(PaginatedDataTable.defaultRowsPerPage));

class CreateAppSelectDataTableWidget extends ConsumerWidget {
  final bool mobile;

  const CreateAppSelectDataTableWidget({
    this.mobile,
  });
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final assignedTbrAsyncValue = watch(assignedTbrStreamProvider);
    return DataTableBuilder(dataAsync: assignedTbrAsyncValue, mobile: mobile);
  }
}

class DataTableBuilder extends ConsumerWidget {
  const DataTableBuilder({
    Key key,
    this.dataAsync,
    @required this.mobile,
  }) : super(key: key);
  final AsyncValue<List<AssignedTBR>> dataAsync;
  final bool mobile;

  @override // 8
  Widget build(BuildContext context, ScopedReader watch) {
    return dataAsync.when(
      data: (items) {
        final bool showAll = watch(showAllSwitchProvider).state;
        final List<AssignedTBR> filteredItems = items.where((element) {
          if (!showAll) {
            return element.status.getStatusName() != 'Completed';
          } else {
            return true;
          }
        }).toList();

        return items.isNotEmpty
            ? ShowDataTable(items: filteredItems, mobile: mobile)
            : const EmptyContent();
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const EmptyContent(
        title: 'Something went wrong',
        message: 'Can\'t load items right now',
      ),
    );
  }
}

class ShowDataTable extends ConsumerWidget {
  const ShowDataTable({Key key, this.items, this.mobile}) : super(key: key);
  final List<AssignedTBR> items;
  final bool mobile;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final TableVars tableVars = watch(tableVarsProvider).state;
    final DTS dtsSource =
        DTS(incomingData: items, context: context, mobile: mobile);

    return Flexible(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DefaultTextStyle(
              style: const TextStyle(fontSize: 10, color: Colors.blue),
              child: CustomPaginatedDataTable(
                showCheckboxColumn: false,
                headingRowColor: Colors.grey[300],
                header: const Text('Select TBR to be completed'),
                source: dtsSource,
                rowsPerPage: tableVars.rowsPerPage,
                sortColumnIndex: tableVars.sortColumnIndex,
                sortAscending: tableVars.sortAscending,
                onRowsPerPageChanged: (rows) {
                  // setState(() {
                  context.read(tableVarsProvider).state.rowsPerPage = rows;
                  // });
                },
                columns: [
                  CustomDataColumn(
                    label: Text(Strings.tbrStrings.status),
                    onSort: (columnIndex, ascending) {
                      dtsSource.sort<String>(
                          getField: (d) => d.status.statusIndex.toString(),
                          ascending: tableVars.sortAscending);
                      // setState(() {
                      final TableVars tempTableVars = TableVars(
                          context.read(tableVarsProvider).state.rowsPerPage);
                      tempTableVars.sortColumnIndex = columnIndex;
                      tempTableVars.sortAscending = ascending;

                      context.read(tableVarsProvider).state = tempTableVars;
                      // });
                    },
                  ),
                  CustomDataColumn(
                    label: Text(Strings.companyStrings.company),
                    onSort: (columnIndex, ascending) {
                      print(dtsSource.data[0].company);
                      dtsSource.sort<String>(
                          // 1
                          getField: (d) => d.company.name,
                          ascending: tableVars.sortAscending);
                      print(dtsSource.data[0].company);
                      // setState(() {
                      final TableVars tableVarsTemp = TableVars(
                          context.read(tableVarsProvider).state.rowsPerPage);
                      tableVarsTemp.sortColumnIndex = columnIndex;
                      tableVarsTemp.sortAscending = ascending;
                      final TableVars beer =
                          context.read(tableVarsProvider).state;
                      print(beer.sortAscending);

                      context.read(tableVarsProvider).state = tableVarsTemp;
                      // });
                    },
                  ),
                  CustomDataColumn(
                    label: Text(Strings.technicianStrings.technician),
                    onSort: (columnIndex, ascending) {
                      print(dtsSource);
                      dtsSource.sort<String>(
                          getField: (d) => d.technician.firstName,
                          ascending: tableVars.sortAscending);
                      print(dtsSource);
                      // setState(() {
                      final TableVars tempTableVars = TableVars(
                          context.read(tableVarsProvider).state.rowsPerPage);
                      tempTableVars.sortColumnIndex = columnIndex;
                      tempTableVars.sortAscending = ascending;

                      context.read(tableVarsProvider).state = tempTableVars;
                      // });
                    },
                  ),
                  CustomDataColumn(
                    label: Text(Strings.tbrStrings.dueDate),
                    onSort: (columnIndex, ascending) {
                      dtsSource.sort<String>(
                          getField: (d) => d.dueDate.toString(),
                          ascending: tableVars.sortAscending);
                      // setState(() {
                      final TableVars tempTableVars = TableVars(
                          context.read(tableVarsProvider).state.rowsPerPage);
                      tempTableVars.sortColumnIndex = columnIndex;
                      tempTableVars.sortAscending = ascending;

                      context.read(tableVarsProvider).state = tempTableVars;
                      // });
                    },
                  ),
                  CustomDataColumn(
                    label: Text(Strings.tbrStrings.meetingDate),
                    onSort: (columnIndex, ascending) {
                      dtsSource.sort<String>(
                          getField: (d) => d.clientMeetingDate.toString(),
                          ascending: tableVars.sortAscending);
                      // setState(() {
                      final TableVars tempTableVars = TableVars(
                          context.read(tableVarsProvider).state.rowsPerPage);
                      tempTableVars.sortColumnIndex = columnIndex;
                      tempTableVars.sortAscending = ascending;

                      context.read(tableVarsProvider).state = tempTableVars;
                      // });
                    },
                  ),
                  CustomDataColumn(
                    label: Text(Strings.tbrStrings.type),
                    onSort: (columnIndex, ascending) {
                      dtsSource.sort<String>(
                          getField: (d) => d.questionnaireType.name,
                          ascending: tableVars.sortAscending);
                      // setState(() {
                      final TableVars tempTableVars = TableVars(
                          context.read(tableVarsProvider).state.rowsPerPage);
                      tempTableVars.sortColumnIndex = columnIndex;
                      tempTableVars.sortAscending = ascending;

                      context.read(tableVarsProvider).state = tempTableVars;
                      // });
                    },
                  ),
                  CustomDataColumn(
                    label: const Text('Assigned By'),
                    onSort: (columnIndex, ascending) {
                      dtsSource.sort<String>(
                          getField: (d) => d.assignedBy,
                          ascending: tableVars.sortAscending);
                      // setState(() {
                      final TableVars tempTableVars = TableVars(
                          context.read(tableVarsProvider).state.rowsPerPage);
                      tempTableVars.sortColumnIndex = columnIndex;
                      tempTableVars.sortAscending = ascending;

                      context.read(tableVarsProvider).state = tempTableVars;
                      // });
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

  DTS({this.incomingData, @required this.context, this.mobile}) {
    filterValues(context);
  }

  void filterValues(BuildContext context) {
    data = incomingData;
  }

  @override
  CustomDataRow getRow(int index) {
    if (index < data.length) {
      return CustomDataRow(
          onSelectChanged: (_) {
            if (data[index].status.getStatusName() != 'Completed') {
              _displayNewTBREvalPage(
                  context: context, assignedTBR: data[index], mobile: false);
            } else {
              final AsyncValue<TBRinProgress> completedTbrAsyncValue =
                  context.read(completedTbrStreamProvider(data[index].id));
              completedTbrAsyncValue.whenData((completedTBR) {
                _displayCompletedTBREvalPage(
                    context: context,
                    assignedTBR: data[index],
                    completedTBR: completedTBR,
                    mobile: false);
              });
            }
          },
          cells: [
            CustomDataCell(statusBox(data[index].status.getStatusName())),
            // ignore: unnecessary_string_interpolations
            CustomDataCell(Text('${data[index].company.toDropDownString()}')),
            CustomDataCell(
                // ignore: unnecessary_string_interpolations
                Text('${data[index].technician.toDropDownString()}')),
            CustomDataCell(
                Text(DateFormat.yMMMEd().format(data[index].dueDate))),
            CustomDataCell(Text(
                DateFormat.yMMMEd().format(data[index].clientMeetingDate))),

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
      final Comparable<T> aValue = getField(a); // 2 - 7
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
} // End of DTS()

Future<void> _displayNewTBREvalPage(
    {@required BuildContext context,
    @required AssignedTBR assignedTBR,
    @required bool mobile}) async {
  //
  context.read(inProgressTbrProvider).state = assignedTBR;
  Widget frame = Container(color: Colors.white, child: const TBRappPage());
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

Future<void> _displayCompletedTBREvalPage(
    {@required BuildContext context,
    @required AssignedTBR assignedTBR,
    @required TBRinProgress completedTBR,
    @required bool mobile}) async {
  context.read(inProgressTbrProvider).state = assignedTBR;

  Widget frame = Container(color: Colors.white, child: const TBRappPage());
  if (mobile) {
    frame = Expanded(
      child: Center(child: addMobileFrame(frame)),
    );
  } else {
    frame = Expanded(child: Center(child: frame));
  }
  print('_displayDialog => $completedTBR');
  context.read(widgetProvider).state = frame;
}
