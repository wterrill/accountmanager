import 'package:accountmanager/app/home/models/assignedTbr.dart';
import 'package:accountmanager/common_widgets/empty_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:intl/intl.dart';

import '../../top_level_providers.dart';

// typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

final assignedTbrStreamProvider =
    StreamProvider.autoDispose<List<AssignedTBR>>((ref) {
  final database = ref.watch(databaseProvider);
  return database?.assignedTbrStream() ?? const Stream.empty();
});

class CreateDataTableWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final assignedTbrAsyncValue = watch(assignedTbrStreamProvider);
    return DataTableBuilder(data: assignedTbrAsyncValue);
  }
}

class DataTableBuilder extends StatefulWidget {
  const DataTableBuilder({Key key, @required this.data}) : super(key: key);
  final AsyncValue<List<AssignedTBR>> data;

  @override
  _DataTableBuilderState<AssignedTBR> createState() =>
      _DataTableBuilderState<AssignedTBR>();
}

class _DataTableBuilderState<AssignedTBR> extends State<DataTableBuilder> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  Widget build(BuildContext context) {
    return widget.data.when(
      data: (items) =>
          items.isNotEmpty ? _datatable(DTS(items)) : const EmptyContent(),
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
                DataColumn(label: Text('Meeting Date')),
                DataColumn(label: Text('Status'))
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
    // print(data);
    // print(data[index]);
    // print(index);
    if (index < data.length) {
      return DataRow(cells: [
        DataCell(Text('${data[index].company}')),
        DataCell(Text('${data[index].technician}')),
        DataCell(Text(DateFormat.yMMMEd().format(data[index].dueDate))),
        DataCell(
            Text(DateFormat.yMMMEd().format(data[index].clientMeetingDate))),
        DataCell(Text(data[index].status.getStatusName()))
      ]);
    } else {
      return const DataRow(cells: [
        DataCell(Text('')),
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
