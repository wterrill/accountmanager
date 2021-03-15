import 'package:accountmanager/app/models/assignedTbr.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/constants/strings.dart';
import 'package:accountmanager/services/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IpaginatedTable extends StatefulWidget {
  const IpaginatedTable({Key key}) : super(key: key);

  @override
  _IpaginatedTableState createState() => _IpaginatedTableState();
}

class _IpaginatedTableState extends State<IpaginatedTable> {
  // final dts = DTS();
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
    final FirestoreDatabase database = context.read(databaseProvider);
    return FutureBuilder(
        future: database.assignedTbrStream().first,
        builder: (context, snapshot) {
          print(snapshot);
          print(snapshot.data);
          if (snapshot.connectionState == ConnectionState.done) {
            print(snapshot);
            print(snapshot.data);
            if (snapshot.hasError) {
              return const Text(Strings.error);
            } else {
              return _datatable(DTS(snapshot.data));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
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

  DTS(this.data);

  @override
  DataRow getRow(int index) {
    print(data);
    // print(data[index]);
    print(index);
    if (index < data.length) {
      return DataRow(cells: [
        DataCell(Text('${data[index].company}')),
        DataCell(Text('${data[index].technician}')),
        DataCell(Text('${data[index].dueDate}')),
        DataCell(Text('${data[index].clientMeetingDate}')),
      ]);
    } else {
      return const DataRow(cells: [
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
