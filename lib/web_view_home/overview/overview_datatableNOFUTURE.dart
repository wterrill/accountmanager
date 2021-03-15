// ignore_for_file: file_names
import 'package:accountmanager/app/models/question.dart';
import 'package:accountmanager/app/models/tbr.dart';
import 'package:accountmanager/common_widgets/CustomDataTable.dart';
import 'package:accountmanager/common_widgets/CustomDataTableSource.dart';
import 'package:accountmanager/common_widgets/CustomPaginatedDataTable.dart';
import 'package:accountmanager/constants/strings.dart';
import 'package:accountmanager/web_view_home/overview/create_datatable_widget2.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OverviewPaginatedTable extends StatefulWidget {
  const OverviewPaginatedTable({Key key, this.id}) : super(key: key);
  final String id;

  @override
  _OverviewPaginatedTableState createState() => _OverviewPaginatedTableState();
}

class _OverviewPaginatedTableState extends State<OverviewPaginatedTable> {
  // final dts = DTS();
  int _rowsPerPage = CustomPaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex = 0;
  bool _sortAscending = false;
  TBRinProgress tbrInProgress;

  @override
  void initState() {
    // tbrInProgress = context.read(completedTbrStreamProvider(widget.id));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final tbrInProgress = context.read(tbrInProgressProvider).state;

    return Consumer(builder: (context, watch, child) {
      final tbrInProgressAsyncValue =
          watch(completedTbrStreamProvider(widget.id));

      return tbrInProgressAsyncValue.when(
        data: (tbrInProgress) => _datatable(DTS(tbrInProgress)),
        loading: () => Container(color: Colors.cyanAccent),
        error: (_, __) => Container(color: Colors.red),
      );
    });
  }

  //   Widget build(BuildContext context, ScopedReader watch) {
  //   final jobAsyncValue = watch(jobStreamProvider(job.id));
  //   return jobAsyncValue.when(
  //     data: (job) => Text(job.name),
  //     loading: () => Container(),
  //     error: (_, __) => Container(),
  //   );
  // }

  Widget _datatable(DTS dtsSource) {
    return Column(
      children: [
        CustomPaginatedDataTable(
          headingRowColor: Colors.blue,
          header: Text(Strings.tbrStrings.assignTbr),
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
                    getField: (d) => d.questionName, ascending: _sortAscending);
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
            )
          ],
        ),
        Container(height: 150),
      ],
    );
  }
}

class DTS extends CustomDataTableSource {
  final TBRinProgress data;
  List<Question> questions;

  DTS(this.data) {
    questions = data.allQuestions;
  }

  @override
  CustomDataRow getRow(int index) {
    final String id = data.allQuestions[index].id;
    print(data);
    // print(data[index]);
    print(index);
    if (index < data.allQuestions.length) {
      return CustomDataRow(cells: [
        CustomDataCell(Text(data.allQuestions[index].category)),
        CustomDataCell(Text(data.allQuestions[index].questionName)),
        CustomDataCell(Text(data.allQuestions[index].questionPriority)),
        CustomDataCell(Text(data.allQuestions[index].questionText)),
        CustomDataCell(getAlignment(
            data.answers[id], data.allQuestions[index].goodBadAnswer)),
      ]);
    } else {
      return const CustomDataRow(cells: [
        CustomDataCell(Text(Strings.placeHolder)),
        CustomDataCell(Text(Strings.placeHolder)),
        CustomDataCell(Text(Strings.placeHolder)),
        CustomDataCell(Text(Strings.placeHolder)),
        CustomDataCell(Text(Strings.placeHolder)),
      ]);
    }
  }

  void sort<T>({Comparable<T> Function(Question d) getField, bool ascending}) {
    questions.sort((a, b) {
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
  int get rowCount => data.allQuestions.length;

  @override
  int get selectedRowCount => 0;
}

Widget getAlignment(List<bool> answerArray, String expected) {
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
