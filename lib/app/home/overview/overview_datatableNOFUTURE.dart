import 'package:accountmanager/app/home/models/assignedTbr.dart';
import 'package:accountmanager/app/home/models/tbr.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/constants/strings.dart';
import 'package:accountmanager/services/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:accountmanager/app/home/app_page/tbr/tbr_entry.dart';

import '../../../common_widgets/CustomDataTable.dart';
import '../../../common_widgets/CustomDataTableSource.dart';
import '../../../common_widgets/CustomPaginatedDataTable.dart';

class OverviewPaginatedTable extends StatefulWidget {
  const OverviewPaginatedTable({Key key}) : super(key: key);

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
    tbrInProgress = context.read(tbrInProgressProvider);
    _sortAscending = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tbrInProgress = context.read(tbrInProgressProvider);
    return _datatable(DTS(tbrInProgress));
  }

  Widget _datatable(DTS dtsSource) {
    return Flexible(
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomPaginatedDataTable(
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
                  label: Text('Name'),
                  // onSort: (columnIndex, ascending) {
                  //   dtsSource.sort<String>(
                  //       getField: (d) => d.company.name,
                  //       ascending: _sortAscending);
                  //   setState(() {
                  //     _sortColumnIndex = columnIndex;
                  //     _sortAscending = !_sortAscending;
                  //   });
                  // },
                ),
                CustomDataColumn(
                  label: Text("Priority"),
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
                CustomDataColumn(
                  label: Text("Question Text"),
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
                CustomDataColumn(
                  label: Text("Aligned (Y/N)"),
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
      ),
    );
  }
}

class DTS extends CustomDataTableSource {
  final TBRinProgress data;

  DTS(this.data);

  @override
  CustomDataRow getRow(int index) {
    final String id = data.allQuestions[index].id;
    print(data);
    // print(data[index]);
    print(index);
    if (index < data.allQuestions.length) {
      return CustomDataRow(cells: [
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
      ]);
    }
  }

  // void sort<T>(
  //     {Comparable<T> Function(TBRinProgress d) getField, bool ascending}) {
  //   data.sort((a, b) {
  //     if (!ascending) {
  //       final AssignedTBR c = a;
  //       a = b;
  //       b = c;
  //     }
  //     final Comparable<T> aValue = getField(a);
  //     final Comparable<T> bValue = getField(b);
  //     return Comparable.compare(aValue, bValue);
  //   });
  //   // notifyListeners();
  // }

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
    return Text('');
  }
  if (answerArray[1] == true && expected == 'N = Bad') {
    return Container(width: 50, color: Colors.red, child: Text('N'));
  } else {
    return Container(width: 50, color: Colors.green, child: Text('Y'));
  }
}
