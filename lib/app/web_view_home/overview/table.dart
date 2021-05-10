// ignore_for_file: file_names

import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/app/web_view_home/overview/excel_button.dart';
import 'package:accountmanager/common_widgets/CustomDataTable.dart';
import 'package:accountmanager/common_widgets/CustomDataTableSource.dart';
import 'package:accountmanager/common_widgets/CustomPaginatedDataTable.dart';
import 'package:accountmanager/constants/strings.dart';
import 'package:accountmanager/models/question.dart';
import 'package:accountmanager/models/tbr.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OverviewPaginatedTable extends StatefulWidget {
  const OverviewPaginatedTable({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  _OverviewPaginatedTableState createState() => _OverviewPaginatedTableState();
}

class _OverviewPaginatedTableState extends State<OverviewPaginatedTable> {
  // final dts = DTS();
  int _rowsPerPage = CustomPaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex = 0;
  bool _sortAscending = false;
  // TBRinProgress tbrInProgress;

  @override
  void initState() {
    print('initState in OverviewPaginatedTableState');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final tbrInProgress = context.read(tbrInProgressProvider).state;
    print('in build for overviewPaginatedTableState');
    // final database = context.watch(databaseProvider);

    return Consumer(
        // ignore: avoid_types_on_closure_parameters
        builder: (BuildContext context, ScopedReader watch, Widget? child) {
      final String id = widget.id;
      print(id);
      print('before completedTbrAsyncValueProvider');
      final AsyncValue<TBRinProgress> completedTbrAsyncValue =
          watch(completedTbrStreamProvider!(id));
      //* This is the code that fails when deploy on the web. it will need to be modified.
//! **********************************************************************
      //* final AsyncValue<TBRinProgress> completedTbrAsyncValue =
      //*     watch(completedTbrStreamProvider(id));
//! **********************************************************************

      print('after completedTbrAsyncValueProvider');
      print(completedTbrAsyncValue);
      print('------------ ----------- ---------');
      return completedTbrAsyncValue.when(
        data: (tbrInProgress) {
          print('got there');
          return _datatable(DTS(tbrInProgress));
        },
        loading: () => Container(color: Colors.cyanAccent),
        error: (_, __) => Container(color: Colors.red),
      );
    }
        // as Widget Function(
        //     BuildContext, T Function<T>(ProviderBase<Object?, T>), Widget?),
        );
  }

  Widget _datatable(DTS dtsSource) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          ExcelButton(
            tbrInProgress: dtsSource.getData(),
          ),
          CustomPaginatedDataTable(
            headingRowColor: Colors.blue,
            header: Text(Strings.tbrStrings.assignTbr),
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
                label: const Text('Category'),
                onSort: (columnIndex, ascending) {
                  dtsSource.sort<String>(
                      getField: (d) => d.category, ascending: _sortAscending);
                  setState(() {
                    _sortColumnIndex = columnIndex;
                    _sortAscending = !_sortAscending;
                  });
                },
              ),
              CustomDataColumn(
                label: const Text('Name'),
                onSort: (columnIndex, ascending) {
                  dtsSource.sort<String>(
                      getField: (d) => d.questionName,
                      ascending: _sortAscending);
                  setState(() {
                    _sortColumnIndex = columnIndex;
                    _sortAscending = !_sortAscending;
                  });
                },
              ),
              const CustomDataColumn(
                label: Text('Priority'),
                // onSort: (columnIndex, ascending) {
                //   dtsSource.sort<String>(
                //       getField: (d) => d.technician.name,
                //       ascending: _sortAscending);
                //   setState(() {
                //     _sortColumnIndex = columnIndex;
                //     _sortAscending = !_sortAscending;
                //   });
                // },
              ),
              const CustomDataColumn(
                label: Text('Question Text'),
                // onSort: (columnIndex, ascending) {
                //   dtsSource.sort<String>(
                //       getField: (d) => d.dueDate.toString(),
                //       ascending: _sortAscending);
                //   setState(() {
                //     _sortColumnIndex = columnIndex;
                //     _sortAscending = !_sortAscending;
                //   });
                // },
              ),
              const CustomDataColumn(
                label: Text('Aligned (Y/N)'),
                // onSort: (columnIndex, ascending) {
                //   dtsSource.sort<String>(
                //       getField: (d) => d.clientMeetingDate.toString(),
                //       ascending: _sortAscending);
                //   setState(() {
                //     _sortColumnIndex = columnIndex;
                //     _sortAscending = !_sortAscending;
                //   });
                // },
              ),
              const CustomDataColumn(
                label: Text('Admin Notes'),
                // onSort: (columnIndex, ascending) {
                //   dtsSource.sort<String>(
                //       getField: (d) => d.clientMeetingDate.toString(),
                //       ascending: _sortAscending);
                //   setState(() {
                //     _sortColumnIndex = columnIndex;
                //     _sortAscending = !_sortAscending;
                //   });
                // },
              ),
              const CustomDataColumn(
                label: Text('TAM Notes'),
                // onSort: (columnIndex, ascending) {
                //   dtsSource.sort<String>(
                //       getField: (d) => d.clientMeetingDate.toString(),
                //       ascending: _sortAscending);
                //   setState(() {
                //     _sortColumnIndex = columnIndex;
                //     _sortAscending = !_sortAscending;
                //   });
                // },
              )
            ],
          ),
          Container(height: 150),
        ],
      ),
    );
  }
}

class DTS extends CustomDataTableSource {
  final TBRinProgress data;
  List<Question>? questions;

  DTS(this.data) {
    questions = data.allQuestions;
  }

  TBRinProgress getData() => data;

  @override
  CustomDataRow getRow(int index) {
    final String? id = data.allQuestions![index].id;
    print(data);
    // print(data[index]);
    print(index);
    if (index < data.allQuestions!.length) {
      return CustomDataRow(cells: [
        CustomDataCell(Container(
            width: 200, child: Text(data.allQuestions![index].category!))),
        CustomDataCell(Container(
            width: 200, child: Text(data.allQuestions![index].questionName!))),
        CustomDataCell(Container(
            width: 50,
            child: Text(data.allQuestions![index].questionPriority!))),
        CustomDataCell(Container(
            width: 400, child: Text(data.allQuestions![index].questionText!))),
        CustomDataCell(getAlignment(
            data.answers![id]!, data.allQuestions![index].goodBadAnswer)),
        CustomDataCell(Container(
            width: 100,
            child:
                Text(data.adminComment![data.allQuestions![index].id] ?? ''))),
        CustomDataCell(Container(
            width: 100,
            child: Text(data.tamNotes![data.allQuestions![index].id] ?? ''))),
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
      {Comparable<T>? Function(Question d)? getField, bool? ascending}) {
    questions!.sort((a, b) {
      if (!ascending!) {
        final Question c = a;
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
  int get rowCount => data.allQuestions!.length;

  @override
  int get selectedRowCount => 0;
}

Widget getAlignment(List<bool> answerArray, String? expected) {
  print(answerArray);
  print(expected);
  if (!answerArray.contains(true)) {
    return const Text('');
  }
  if (answerArray[1] == true && expected == 'N = Bad') {
    return Container(
        width: 50,
        color: const Color(0x55f44336),
        child: const Center(child: Text('N')));
  } else if (answerArray[2] == true) {
    return Container(
        width: 50,
        color: const Color(0x559e9e9e),
        child: const Center(child: Text('N/A')));
  } else {
    return Container(
        width: 50,
        color: const Color(0x554caf50),
        child: const Center(child: Text('Y')));
  }
}
