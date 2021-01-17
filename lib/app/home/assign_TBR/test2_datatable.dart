// import 'package:accountmanager/app/home/jobs/empty_content.dart';
// import 'package:accountmanager/app/home/models/assignedTbr.dart';
// import 'package:accountmanager/services/firestore_database.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../top_level_providers.dart';

// typedef DataTableWidgetBuilder<T> = Widget Function(
//     BuildContext context, T item);

// class DataTableBuilderConsumer<T> extends ConsumerWidget {
//   final dynamic inputStreamProvider;

//   const DataTableBuilderConsumer({this.inputStreamProvider});

//   @override
//   Widget build(BuildContext context, ScopedReader watch) {
//     return Container(
//       child: DataTableBuilder<List<T>>(data: watch(inputStreamProvider)),
//     );
//   }
// }

// class DataTableBuilder<List<T>> extends StatefulWidget {
//   const DataTableBuilder({
//     Key key,
//     @required this.data,
//     // @required this.inputStreamProvider
//     // @required this.itemBuilder,
//   }) : super(key: key);

//   final AsyncValue<List<T>> data;
//   // final StreamProvider<List<T>> inputStreamProvider;

//   // final DataTableWidgetBuilder<T> itemBuilder;

//   @override
//   _DataTableBuilderState<T> createState() => _DataTableBuilderState<T>();
// }

// class _DataTableBuilderState<T> extends State<DataTableBuilder<T>> {
//   int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
//   @override
//   Widget build(BuildContext context) {
//     return widget.data.when(
//       data: (items) =>
//           items.isNotEmpty ? _buildDataTable(DTS(items)) : const EmptyContent(),
//       loading: () => const Center(child: CircularProgressIndicator()),
//       error: (_, __) => const EmptyContent(
//         title: 'Something went wrong',
//         message: 'Can\'t load items right now',
//       ),
//     );
//   }

//   //   Widget _buildDataTable(List<T> items) {
//   //   return ListView.separated(
//   //     itemCount: items.length + 2,
//   //     separatorBuilder: (context, index) => const Divider(height: 0.5),
//   //     itemBuilder: (context, index) {
//   //       if (index == 0 || index == items.length + 1) {
//   //         return Container(); // zero height: not visible
//   //       }
//   //       return widget.itemBuilder(context, items[index - 1]);
//   //     },
//   //   );
//   // }

//   Widget _buildDataTable(DTS dtsSource) {
//     return Flexible(
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             PaginatedDataTable(
//               header: const Text('header'),
//               source: dtsSource,
//               rowsPerPage: _rowsPerPage,
//               onRowsPerPageChanged: (rows) {
//                 setState(() {
//                   _rowsPerPage = rows;
//                 });
//               },
//               columns: const [
//                 DataColumn(label: Text('Company Name')),
//                 DataColumn(label: Text('Technician')),
//                 DataColumn(label: Text('Due Date')),
//                 DataColumn(label: Text('Meeting Date'))
//               ],
//             ),
//             Container(height: 150),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class DTS extends DataTableSource {
//   final List<AssignedTBR> data;

//   DTS(this.data);

//   @override
//   DataRow getRow(int index) {
//     print(data);
//     print(index);
//     if (index < data.length) {
//       return DataRow(cells: [
//         DataCell(Text('${data[index].company}')),
//         DataCell(Text('${data[index].technician}')),
//         DataCell(Text('${data[index].dueDate}')),
//         DataCell(Text('${data[index].clientMeetingDate}')),
//       ]);
//     } else {
//       return const DataRow(cells: [
//         DataCell(Text('')),
//         DataCell(Text('')),
//         DataCell(Text('')),
//         DataCell(Text('')),
//       ]);
//     }
//   }

//   @override
//   bool get isRowCountApproximate => true;

//   @override
//   int get rowCount => 100;

//   @override
//   int get selectedRowCount => 0;
// }
