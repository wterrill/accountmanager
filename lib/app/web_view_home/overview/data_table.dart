import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/app/web_view_home/overview/table.dart';
import 'package:accountmanager/common_widgets/CustomDataTable.dart';
import 'package:accountmanager/common_widgets/CustomDataTableSource.dart';
import 'package:accountmanager/common_widgets/CustomPaginatedDataTable.dart';
import 'package:accountmanager/common_widgets/empty_content.dart';
import 'package:accountmanager/constants/strings.dart';
import 'package:accountmanager/models/assigned_tbr.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

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
    (ref) => TableVars(CustomPaginatedDataTable.defaultRowsPerPage));

class CreateOverviewSelectDataTableWidget extends ConsumerWidget {
  final bool mobile;

  const CreateOverviewSelectDataTableWidget({
    this.mobile,
  });
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final assignedTbrAsyncValue = watch(assignedTbrStreamProvider);
    final questionsAsync = watch(questionStreamProvider);
    questionsAsync.whenData((questions) {
      watch(latestQuestionsProvider).state = questions;
    });
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
    // final TableVars tableVars = watch(tableVarsProvider).state;
    // final bool showAll = watch(showAllSwitchProvider).state;
    // print(showAll);

    return dataAsync.when(
      data: (items) {
        final List<AssignedTBR> filteredItems = items
            .where((element) => element.status.getStatusName() == 'Completed')
            .toList();

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
    final DTS dtsSource =
        DTS(incomingData: items, mobile: mobile, context: context);
    final TableVars tableVars = watch(tableVarsProvider).state;
    // final bool showAll = watch(showAllSwitchProvider).state;

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
                          getField: (d) => d.technician.name,
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

  DTS({this.incomingData, this.context, this.mobile}) {
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

Future<void> _displayNextPage(
    {@required BuildContext context,
    AssignedTBR assignedTBR,
    bool mobile}) async {
  final String id = assignedTBR.id; //OverviewPaginatedTable(id: id);
  Widget frame = Container(
    alignment: Alignment.topCenter,
    color: Colors.white,
    child: SingleChildScrollView(
      // scrollDirection: Axis.horizontal,
      child: OverviewPaginatedTable(id: id),
    ),
  );
  frame = Expanded(child: Center(child: frame));
  context.read(widgetProvider).state = frame;
}
