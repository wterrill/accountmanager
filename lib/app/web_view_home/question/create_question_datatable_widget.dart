import 'package:accountmanager/constants/text_styles.dart';
import 'package:accountmanager/models/question.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/common_widgets/CustomDataTable.dart';
import 'package:accountmanager/common_widgets/CustomDataTableSource.dart';
import 'package:accountmanager/common_widgets/CustomPaginatedDataTable.dart';
import 'package:accountmanager/constants/color_defs.dart';
import 'package:accountmanager/constants/strings.dart';
import 'package:accountmanager/app/web_view_home/question/edit_question.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pedantic/pedantic.dart';
import 'package:accountmanager/common_widgets/empty_content.dart';
import 'package:accountmanager/packages/alert_dialogs/alert_dialogs.dart';

class CreateQuestionDataTableWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final questionAsyncValue = watch(questionStreamProvider!);
    return DataTableBuilder(data: questionAsyncValue);
  }
}

class DataTableBuilder extends StatefulWidget {
  const DataTableBuilder({Key? key, required this.data}) : super(key: key);
  final AsyncValue<List<Question>> data;

  @override
  _DataTableBuilderState createState() => _DataTableBuilderState();
}

class _DataTableBuilderState extends State<DataTableBuilder> {
  int? _rowsPerPage = CustomPaginatedDataTable.defaultRowsPerPage;
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

    return
        // Column(
        //   children: [
        CustomPaginatedDataTable(
      showCheckboxColumn: false,
      header: Text(Strings.questionStrings.header),
      source: dtsSource,
      rowsPerPage: _rowsPerPage,
      sortColumnIndex: _sortColumnIndex,
      sortAscending: _sortAscending,
      headingRowColor: Colors.transparent,
      cardBackgroundColor: Colors.transparent,
      mainBackgroundColor: Colors.transparent,
      footerBackgroundColor: Colors.transparent,
      cardElevation: 0,
      dropdownTextStyle: const TextStyle(color: Colors.blue, fontSize: 15.0),
      pageRowInfoTextStyle: TextStyles.textBodyBronze20,
      onRowsPerPageChanged: (rows) {
        setState(() {
          _rowsPerPage = rows;
        });
      },
      columns: [
        CustomDataColumn(
          label: Text(Strings.questionStrings.category),
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
            dtsSource.sort<String>(
                getField: (d) => d.category, ascending: _sortAscending);
            setState(() {
              _sortColumnIndex = columnIndex;
              _sortAscending = !_sortAscending;
            });
          },
        ),
        // CustomDataColumn(label: Text(Strings.questionStrings.benefits)),
        CustomDataColumn(
          // label: Text(Strings.questionStrings.questionText),
          label: const Text('Question'),
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
          // label: Text(Strings.questionStrings.questionPriority),
          label: const Text('Priority'),
          onSort: (columnIndex, ascending) {
            dtsSource.sort<String>(
                getField: (d) => d.questionPriority, ascending: _sortAscending);
            setState(() {
              _sortColumnIndex = columnIndex;
              _sortAscending = !_sortAscending;
            });
          },
        ),
        // CustomDataColumn(
        //   label: Text(Strings.questionStrings.type),
        //   onSort: (columnIndex, ascending) {
        //     dtsSource.sort<String>(
        //         getField: (d) => d.type, ascending: _sortAscending);
        //     setState(() {
        //       _sortColumnIndex = columnIndex;
        //       _sortAscending = !_sortAscending;
        //     });
        //   },
        // ),
        CustomDataColumn(label: Text(Strings.questionStrings.whyAreWeAsking))
      ],
    );
    // Container(height: 150),
    //   ],
    // );
    //   ),
    // );
  }
}

class DTS extends CustomDataTableSource {
  final List<Question> data;
  final BuildContext context;

  DTS(
    this.data,
    this.context,
  );

  @override
  CustomDataRow getRow(int index) {
    if (index < data.length) {
      return CustomDataRow(
          onSelectChanged: (_) {
            _displayDialog(context, data[index]);
          },
          cells: [
            CustomDataCell(Text(data[index].category ?? '')),
            // CustomDataCell(Text(data[index]?.benefitsBusinessValue ?? '')),
            CustomDataCell(Text(data[index].questionText ?? '')),
            CustomDataCell(Text(data[index].questionPriority ?? '')),
            // CustomDataCell(Text(data[index]?.type ?? '')),
            CustomDataCell(Text(data[index].whyAreWeAsking ?? ''))
          ]);
    } else {
      return const CustomDataRow(cells: [
        CustomDataCell(Text(Strings.placeHolder)),
        // CustomDataCell(Text(Strings.placeHolder)),
        CustomDataCell(Text(Strings.placeHolder)),
        CustomDataCell(Text(Strings.placeHolder)),
        // CustomDataCell(Text(Strings.placeHolder)),
        CustomDataCell(Text(Strings.placeHolder)),
      ]);
    }
  }

  void sort<T>(
      {Comparable<T>? Function(Question d)? getField, bool? ascending}) {
    data.sort((a, b) {
      if (!ascending!) {
        final Question c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField!(a)!;
      final Comparable<T> bValue = getField(b)!;
      return Comparable.compare(aValue, bValue);
    });
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

Future<void> _displayDialog(BuildContext context, Question data) async {
  print('_displayDialog => $data');
  try {
    final Map<String, dynamic>? result = await showWidgetDialog(
        context: context,
        title: 'TBR Questions',
        widget:
            EditQuestion(data: data) //DropdownScreen() //AssignTBR(data: data),
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
