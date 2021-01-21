import 'package:accountmanager/app/home/models/question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:intl/intl.dart';
import 'package:pedantic/pedantic.dart';

import 'package:accountmanager/app/home/assign_TBR/widget_assign_TBR2.dart';
import 'package:accountmanager/common_widgets/empty_content.dart';
import 'package:accountmanager/packages/alert_dialogs/alert_dialogs.dart';

import '../../top_level_providers.dart';

final questionStreamProvider =
    StreamProvider.autoDispose<List<Question>>((ref) {
  final database = ref.watch(databaseProvider);
  return database?.questionStream() ?? const Stream.empty();
}); //**//**//**//**/

class CreateDataTableWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final questionAsyncValue = watch(questionStreamProvider); //**//**//**//**/
    return DataTableBuilder(data: questionAsyncValue);
  }
}

class DataTableBuilder extends StatefulWidget {
  const DataTableBuilder({Key key, @required this.data}) : super(key: key);
  final AsyncValue<List<Question>> data; //**//**//**//**/

  @override
  _DataTableBuilderState createState() => //**//**//**//**/
      _DataTableBuilderState(); //**//**//**//**/
}

class _DataTableBuilderState extends State<DataTableBuilder> {
  //**//**//**//**/
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  // bool sort = true;

  // // int _rowsPerPage = CustomPaginatedDataTable.defaultRowsPerPage;
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

  // void _sort<T>(Comparable<T> getField(Question d), int columnIndex,
  //     bool ascending, DTS dtsSource) {
  // print('columnIndex: $columnIndex');
  // print('ascending: $ascending');
  // dtsSource.sort<T>(getField, ascending);
  // setState(() {
  //   _sortColumnIndex = columnIndex;
  //   _sortAscending = !_sortAscending;
  // });
  // print(_sortAscending);
  // }

  Widget _datatable(DTS dtsSource) {
    // void onSortColum({int columnIndex, bool ascending}) {
    //   if (columnIndex == 0) {
    //     if (ascending) {
    //       dtsSource.data.sort((a, b) => a.category.compareTo(b.category));
    //     } else {
    //       dtsSource.data.sort((a, b) => b.category.compareTo(a.category));
    //     }
    //   }
    // }

    return Flexible(
      child: SingleChildScrollView(
        child: Column(
          children: [
            PaginatedDataTable(
              showCheckboxColumn: false,
              header: const Text('questions'),
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
                  label: const Text('Category'),
                  // onSort: (columnIndex, ascending) => _sort<String>(
                  //     (Question d) => d.category, columnIndex, ascending),
                  // onSort: (columnIndex, ascending) {
                  //   setState(() {
                  //     sort = !sort;
                  //     print(sort);
                  //   });
                  //   onSortColum(columnIndex: columnIndex, ascending: sort);
                  // },
                  // onSort: (int columnIndex, bool ascending) {
                  //   print("sorting");
                  //   _sort<String>((Question d) => d.category, columnIndex,
                  //       ascending, dtsSource);
                  // },
                  onSort: (columnIndex, ascending) {
                    // _sort<String>((Question d) => d.category, columnIndex,
                    //     ascending, dtsSource);
                    dtsSource.sort<String>((d) => d.category, _sortAscending);
                    setState(() {
                      _sortColumnIndex = columnIndex;
                      _sortAscending = !_sortAscending;
                    });
                  },
                ),
                const DataColumn(label: Text('Benefits Business Value')),
                DataColumn(
                  label: const Text('Question Text'),
                  onSort: (columnIndex, ascending) {
                    // _sort<String>((Question d) => d.category, columnIndex,
                    //     ascending, dtsSource);
                    dtsSource.sort<String>((d) => d.category, _sortAscending);
                    setState(() {
                      _sortColumnIndex = columnIndex;
                      _sortAscending = !_sortAscending;
                    });
                  },
                ),
                const DataColumn(label: Text('Question Priority')),
                const DataColumn(label: Text('Type')),
                const DataColumn(label: Text('Why are we asking?'))
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
  final List<Question> data; //**//**//**//**/
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
          onSelectChanged: (beer) {
            print(beer);
            print("working");
            _displayDialog(context, data[index]);
          },
          cells: [
            DataCell(Text(data[index]?.category ?? '')),
            DataCell(Text(data[index]?.benefitsBusinessValue ?? '')),
            DataCell(Text(data[index]?.questionText ?? '')),
            DataCell(Text(data[index]?.questionPriority ?? '')),
            DataCell(Text(data[index]?.type ?? '')),
            DataCell(Text(data[index]?.whyAreWeAsking ?? ''))
          ]);
    } else {
      return const DataRow(cells: [
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
      ]);
    }
  }

  @override
  void sort<T>(Comparable<T> getField(Question d), bool ascending) {
    data.sort((a, b) {
      if (!ascending) {
        final Question c = a;
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

Future<void> _displayDialog(BuildContext context, Question data) async {
  //**//**//**//**/
  //**//**//**//**/
  print('_displayDialog => $data');
  try {
    final Map<String, dynamic> result = await showWidgetDialog(
        context: context,
        title: 'Assign TBR',
        widget: Text('beer') //AssignTBR(data: data),  //**//**//**//**/
        // defaultActionText: '',
        // cancelActionText: '',
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