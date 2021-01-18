import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:intl/intl.dart';
import 'package:pedantic/pedantic.dart';

import 'package:accountmanager/app/home/assign_TBR/widget_assign_TBR2.dart';
import 'package:accountmanager/app/home/models/assignedTbr.dart';
import 'package:accountmanager/common_widgets/empty_content.dart';
import 'package:accountmanager/packages/alert_dialogs/alert_dialogs.dart';

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

  Widget _datatable(DTS dtsSource) {
    return Flexible(
      child: SingleChildScrollView(
        child: Column(
          children: [
            PaginatedDataTable(
              showCheckboxColumn: false,
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
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Type'))
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
            DataCell(Text('${data[index].company}')),
            DataCell(Text('${data[index].technician}')),
            DataCell(Text(DateFormat.yMMMEd().format(data[index].dueDate))),
            DataCell(Text(
                DateFormat.yMMMEd().format(data[index].clientMeetingDate))),
            DataCell(Text(data[index].status.getStatusName())),
            DataCell(Text(data[index].questionnaireType.name))
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
  bool get isRowCountApproximate => true;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

Future<void> _displayDialog(BuildContext context, AssignedTBR data) async {
  print('_displayDialog => $data');
  try {
    final Map<String, dynamic> result = await showWidgetDialog(
      context: context,
      title: 'Assign TBR',
      widget: AssignTBR(data: data),
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
