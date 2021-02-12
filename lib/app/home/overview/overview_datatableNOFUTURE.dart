import 'package:accountmanager/app/home/models/assignedTbr.dart';
import 'package:accountmanager/app/home/models/tbr.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/constants/strings.dart';
import 'package:accountmanager/services/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:accountmanager/app/home/app_page/tbr/tbr_entry.dart';

class OverviewPaginatedTable extends StatefulWidget {
  const OverviewPaginatedTable({Key key}) : super(key: key);

  @override
  _OverviewPaginatedTableState createState() => _OverviewPaginatedTableState();
}

class _OverviewPaginatedTableState extends State<OverviewPaginatedTable> {
  // final dts = DTS();
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex = 0;
  bool _sortAscending = false;
  TBRinProgress tbrInProgress;

  @override
  void initState() {
    // tbrInProgress = context.read(tbrInProgressProvider);
    _sortAscending = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final tbrInProgress = context.read(tbrInProgressProvider);
    // final firebaseAuth = context.read(firebaseAuthProvider);
    // final FirestoreDatabase database = context.read(databaseProvider);
    return _datatable(DTS(tbrInProgress));
  }

  Widget _datatable(DTS dtsSource) {
    return Flexible(
      child: SingleChildScrollView(
        child: Column(
          children: [
            PaginatedDataTable(
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
                DataColumn(
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
                // DataColumn(
                //   label: Text(Strings.technicianStrings.technician),
                //   onSort: (columnIndex, ascending) {
                //     dtsSource.sort<String>(
                //         getField: (d) => d.technician.name,
                //         ascending: _sortAscending);
                //     setState(() {
                //       _sortColumnIndex = columnIndex;
                //       _sortAscending = !_sortAscending;
                //     });
                //   },
                // ),
                // DataColumn(
                //   label: Text(Strings.tbrStrings.dueDate),
                //   onSort: (columnIndex, ascending) {
                //     dtsSource.sort<String>(
                //         getField: (d) => d.dueDate.toString(),
                //         ascending: _sortAscending);
                //     setState(() {
                //       _sortColumnIndex = columnIndex;
                //       _sortAscending = !_sortAscending;
                //     });
                //   },
                // ),
                // DataColumn(
                //   label: Text(Strings.tbrStrings.meetingDate),
                //   onSort: (columnIndex, ascending) {
                //     dtsSource.sort<String>(
                //         getField: (d) => d.clientMeetingDate.toString(),
                //         ascending: _sortAscending);
                //     setState(() {
                //       _sortColumnIndex = columnIndex;
                //       _sortAscending = !_sortAscending;
                //     });
                //   },
                // )
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
  final TBRinProgress data;

  DTS(this.data);

  @override
  DataRow getRow(int index) {
    print(data);
    // print(data[index]);
    print(index);
    if (index < data.allQuestions.length) {
      return DataRow(cells: [
        DataCell(Text('${data.allQuestions[index]}')),
        // DataCell(Text('${data[index].technician}')),
        // DataCell(Text('${data[index].dueDate}')),
        // DataCell(Text('${data[index].clientMeetingDate}')),
      ]);
    } else {
      return const DataRow(cells: [
        DataCell(Text(Strings.placeHolder)),
        // DataCell(Text(Strings.placeHolder)),
        // DataCell(Text(Strings.placeHolder)),
        // DataCell(Text(Strings.placeHolder)),
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
