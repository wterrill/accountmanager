import 'package:accountmanager/app/home/models/assignedTbr.dart';
import 'package:accountmanager/services/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../top_level_providers.dart';

final companyStreamProvider =
    StreamProvider.autoDispose<List<AssignedTBR>>((ref) {
  final database = ref.watch(databaseProvider);
  return database?.assignedTbrStream() ?? const Stream.empty();
});

class IpaginatedTable extends StatefulWidget {
  const IpaginatedTable({Key key}) : super(key: key);

  @override
  _IpaginatedTableState createState() => _IpaginatedTableState();
}

class _IpaginatedTableState extends State<IpaginatedTable> {
  // final dts = DTS();
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

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
              return const Text('oh crap');
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
              header: const Text('header'),
              source: dtsSource,
              rowsPerPage: _rowsPerPage,
              onRowsPerPageChanged: (rows) {
                setState(() {
                  _rowsPerPage = rows;
                });
              },
              columns: const [
                DataColumn(label: Text('Company Name')),
                DataColumn(label: Text('Technician')),
                DataColumn(label: Text('Due Date')),
                DataColumn(label: Text('Meeting Date'))
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
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
      ]);
    }
  }

  @override
  bool get isRowCountApproximate => true;

  @override
  int get rowCount => 100;

  @override
  int get selectedRowCount => 0;
}
