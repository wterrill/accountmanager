import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/app/web_view_home/create_technician/create_tech_page.dart';
// import 'package:accountmanager/app/web_view_home/home/sidebar/sidebar.dart';
import 'package:accountmanager/app/web_view_home/overview/table.dart';
import 'package:accountmanager/app/web_view_home/overview/tbr_app_page.dart';
import 'package:accountmanager/common_utilities/get_techs_from_ids.dart';
import 'package:accountmanager/common_widgets/CustomDataTable.dart';
import 'package:accountmanager/common_widgets/CustomDataTableSource.dart';
import 'package:accountmanager/common_widgets/CustomPaginatedDataTable.dart';
import 'package:accountmanager/common_widgets/empty_content.dart';
import 'package:accountmanager/common_widgets/status_box.dart';
import 'package:accountmanager/constants/strings.dart';
import 'package:accountmanager/models/assigned_tbr.dart';
import 'package:accountmanager/models/business_reasons.dart';
import 'package:accountmanager/models/technician.dart';
// import 'package:accountmanager/services/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

final AutoDisposeStreamProvider<List<AssignedTBR>>? assignedTbrStreamProvider =
    StreamProvider.autoDispose<List<AssignedTBR>>((ref) {
  final database = ref.watch(databaseProvider);
  return database?.assignedTbrStream() ?? const Stream.empty();
});

class TableVars {
  TableVars(this.rowsPerPage) {
    sortColumnIndex = 0;
    sortAscending = true;
  }
  int rowsPerPage;
  int? sortColumnIndex;
  bool? sortAscending;
}

final tableVarsProvider = StateProvider<TableVars>(
    (ref) => TableVars(CustomPaginatedDataTable.defaultRowsPerPage));

class CreateOverviewSelectDataTableWidget extends ConsumerWidget {
  final bool? mobile;

  const CreateOverviewSelectDataTableWidget({
    this.mobile,
  });
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final techniciansAsync = watch(asyncTechnicianStreamProvider!);
    final assignedTbrAsyncValue = watch(assignedTbrStreamProvider!);
    final questionsAsync = watch(questionStreamProvider!);
    final AsyncValue<List<BusinessReasons>> businessReasonsAsync =
        watch(businessReasonsStreamProvider);

    techniciansAsync.whenData((technicians) {
      watch(techniciansProvider).state = technicians;
    });
    questionsAsync.whenData((questions) {
      watch(latestQuestionsProvider).state = questions;
    });
    businessReasonsAsync.whenData((businessReasons) {
      watch(latestBusinessReasonsProvider).state = businessReasons;
    });

    return DataTableBuilder(
        assignedDataAsync: assignedTbrAsyncValue, mobile: mobile);
  }
}

class DataTableBuilder extends ConsumerWidget {
  const DataTableBuilder({
    Key? key,
    this.assignedDataAsync,
    this.technicianDataAsync,
    required this.mobile,
  }) : super(key: key);
  final AsyncValue<List<AssignedTBR>>? assignedDataAsync;
  final AsyncValue<List<Technician>>? technicianDataAsync;
  final bool? mobile;

  @override // 8
  Widget build(BuildContext context, ScopedReader watch) {
    return assignedDataAsync!.when(
      data: (items) {
        // final List<AssignedTBR> filteredItems = items
        //     .where((element) => element.status.getStatusName() == 'Completed')
        //     .toList();

        return items.isNotEmpty
            ? ShowDataTable(items: items, mobile: mobile)
            : const EmptyContent();
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const EmptyContent(
        title: 'Something went wrong',
        message: 'Can\'t load items right now',
      ),
    );
  }
}

class ShowDataTable extends ConsumerWidget {
  const ShowDataTable({Key? key, this.items, this.mobile}) : super(key: key);
  final List<AssignedTBR>? items;
  final bool? mobile;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final DTS dtsSource =
        DTS(incomingData: items, mobile: mobile, context: context);
    final TableVars tableVars = watch(tableVarsProvider).state;

    return Flexible(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DefaultTextStyle(
              style: const TextStyle(fontSize: 10, color: Colors.blue),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.red)),
                child: CustomPaginatedDataTable(
                  showCheckboxColumn: false,
                  headingRowColor: Colors.grey[300],
                  header: const Text('Select TBR to be completed'),
                  source: dtsSource,
                  rowsPerPage: tableVars.rowsPerPage,
                  sortColumnIndex: tableVars.sortColumnIndex,
                  sortAscending: tableVars.sortAscending!,
                  onRowsPerPageChanged: (rows) {
                    // setState(() {
                    context.read(tableVarsProvider).state.rowsPerPage = rows!;
                    // });
                  },
                  columns: [
                    CustomDataColumn(
                      label: Text(Strings.tbrStrings.status),
                      onSort: (columnIndex, ascending) {
                        dtsSource.sort<String>(
                            getField: (d) => d.status.statusIndex.toString(),
                            ascending: tableVars.sortAscending);
                        // setState(() {
                        final TableVars tempTableVars = TableVars(
                            context.read(tableVarsProvider).state.rowsPerPage);
                        tempTableVars.sortColumnIndex = columnIndex;
                        tempTableVars.sortAscending = ascending;

                        context.read(tableVarsProvider).state = tempTableVars;
                        // });
                      },
                    ),
                    CustomDataColumn(
                      label: Text(Strings.companyStrings.company),
                      onSort: (columnIndex, ascending) {
                        print(dtsSource.data![0].company);
                        dtsSource.sort<String>(
                            // 1
                            getField: (d) => d.company.name,
                            ascending: tableVars.sortAscending);
                        print(dtsSource.data![0].company);
                        // setState(() {
                        final TableVars tableVarsTemp = TableVars(
                            context.read(tableVarsProvider).state.rowsPerPage);
                        tableVarsTemp.sortColumnIndex = columnIndex;
                        tableVarsTemp.sortAscending = ascending;
                        final TableVars beer =
                            context.read(tableVarsProvider).state;
                        print(beer.sortAscending);

                        context.read(tableVarsProvider).state = tableVarsTemp;
                        // });
                      },
                    ),
                    CustomDataColumn(
                      label: Text(Strings.technicianStrings.technician),
                      onSort: (columnIndex, ascending) {
                        print(dtsSource);
                        dtsSource.sort<String>(
                            getField: (d) =>
                                "TODO", //d.technicianIds.firstName, //TODO this is the techs first name
                            ascending: tableVars.sortAscending);
                        print(dtsSource);
                        // setState(() {
                        final TableVars tempTableVars = TableVars(
                            context.read(tableVarsProvider).state.rowsPerPage);
                        tempTableVars.sortColumnIndex = columnIndex;
                        tempTableVars.sortAscending = ascending;

                        context.read(tableVarsProvider).state = tempTableVars;
                        // });
                      },
                    ),
                    CustomDataColumn(
                      label: Text(Strings.tbrStrings.dueDate),
                      onSort: (columnIndex, ascending) {
                        dtsSource.sort<String>(
                            getField: (d) => d.dueDate.toString(),
                            ascending: tableVars.sortAscending);
                        // setState(() {
                        final TableVars tempTableVars = TableVars(
                            context.read(tableVarsProvider).state.rowsPerPage);
                        tempTableVars.sortColumnIndex = columnIndex;
                        tempTableVars.sortAscending = ascending;

                        context.read(tableVarsProvider).state = tempTableVars;
                        // });
                      },
                    ),
                    CustomDataColumn(
                      label: Text(Strings.tbrStrings.meetingDate),
                      onSort: (columnIndex, ascending) {
                        dtsSource.sort<String>(
                            getField: (d) => d.clientMeetingDate.toString(),
                            ascending: tableVars.sortAscending);
                        // setState(() {
                        final TableVars tempTableVars = TableVars(
                            context.read(tableVarsProvider).state.rowsPerPage);
                        tempTableVars.sortColumnIndex = columnIndex;
                        tempTableVars.sortAscending = ascending;

                        context.read(tableVarsProvider).state = tempTableVars;
                        // });
                      },
                    ),
                    CustomDataColumn(
                      label: Text(Strings.tbrStrings.type),
                      onSort: (columnIndex, ascending) {
                        dtsSource.sort<String>(
                            getField: (d) => d.questionnaireType!.name,
                            ascending: tableVars.sortAscending);
                        // setState(() {
                        final TableVars tempTableVars = TableVars(
                            context.read(tableVarsProvider).state.rowsPerPage);
                        tempTableVars.sortColumnIndex = columnIndex;
                        tempTableVars.sortAscending = ascending;

                        context.read(tableVarsProvider).state = tempTableVars;
                        // });
                      },
                    ),
                    CustomDataColumn(
                      label: const Text('Assigned By'),
                      onSort: (columnIndex, ascending) {
                        dtsSource.sort<String>(
                            getField: (d) => d.assignedBy,
                            ascending: tableVars.sortAscending);
                        // setState(() {
                        final TableVars tempTableVars = TableVars(
                            context.read(tableVarsProvider).state.rowsPerPage);
                        tempTableVars.sortColumnIndex = columnIndex;
                        tempTableVars.sortAscending = ascending;

                        context.read(tableVarsProvider).state = tempTableVars;
                        // });
                      },
                    )
                  ],
                ),
              ),
            ),
            Container(height: 150),
          ],
        ),
      ),
    );
  }
}

class DTS extends CustomDataTableSource {
  final List<AssignedTBR>? incomingData;
  List<AssignedTBR>? data;
  final BuildContext? context;
  final bool? mobile;

  DTS({this.incomingData, this.context, this.mobile}) {
    filterValues(context);
  }

  void filterValues(BuildContext? context) {
    data = incomingData;
  }

  @override
  CustomDataRow getRow(int index) {
    if (index < data!.length) {
      return CustomDataRow(
          onSelectChanged: (_) {
            if (data![index].status.getStatusName() == 'Completed') {
              _displayCompletedTBRSummary(
                context: context!,
                assignedTBR: data![index],
                mobile: mobile,
              );
            }
            if (data![index].status.getStatusName() != 'Completed') {
              _displayNewTBREvalPage(
                  context: context, assignedTBR: data![index], mobile: false);
            }
          },
          cells: [
            CustomDataCell(statusBox(data![index].status.getStatusName())),
            // ignore: unnecessary_string_interpolations
            CustomDataCell(Text('${data![index].company.toDropDownString()}')),
            CustomDataCell(
                // ignore: unnecessary_string_interpolations
                getAvatarRow(data![index].technicianIds, context!)),
            CustomDataCell(
                Text(DateFormat.yMMMEd().format(data![index].dueDate))),
            CustomDataCell(Text(
                DateFormat.yMMMEd().format(data![index].clientMeetingDate))),

            CustomDataCell(Text(data![index].questionnaireType!.name)),
            CustomDataCell(Text(data![index].assignedBy))
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

  Widget getAvatarRow(List<String> techIds, BuildContext context) {
    final List<Widget> avatars = [];
    final List<Technician> returnedTechs = getTechsFromId(techIds, context);
    for (final Technician tech in returnedTechs) {
      avatars.add(SizedBox(
          width: 20,
          child: Tooltip(
              message: '${tech.firstName} ${tech.lastName}',
              child: SvgPicture.asset('assets/avatars/${tech.filename}'))));
    }
    return SizedBox(
        width: 150,
        child: Row(mainAxisSize: MainAxisSize.min, children: avatars));
  }

  void sort<T>(
      {Comparable<T>? Function(AssignedTBR d)? getField, bool? ascending}) {
    data!.sort((a, b) {
      if (!ascending!) {
        final AssignedTBR c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField!(a)!; // 2 - 7
      final Comparable<T> bValue = getField(b)!;
      return Comparable.compare(aValue, bValue);
    });
    // notifyListeners();
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data!.length;

  @override
  int get selectedRowCount => 0;
} // End of DTS()

Future<void> _displayNewTBREvalPage(
    {required BuildContext? context,
    required AssignedTBR assignedTBR,
    required bool mobile}) async {
  //
  context!.read(assignedTbrProvider).state = assignedTBR;
  Widget frame = Container(color: Colors.white, child: const TBRappPage());
  if (mobile) {
    // frame = Expanded(
    //   child: Center(child: addMobileFrame(frame)),
    // );
  } else {
    frame = Expanded(child: Center(child: frame));
  }
  print('_displayDialog => $assignedTBR');
  context.read(widgetProvider).state = frame;
}

Future<void> _displayCompletedTBRSummary(
    {required BuildContext context,
    required AssignedTBR assignedTBR,
    bool? mobile}) async {
  context.read(assignedTbrProvider).state = assignedTBR;
  final String id = assignedTBR.id; //OverviewPaginatedTable(id: id);
  Widget frame = Container(
    alignment: Alignment.topCenter,
    color: Colors.white,
    child: SingleChildScrollView(
      // scrollDirection: Axis.horizontal,
      child: OverviewPaginatedTable(id: id),
    ),
  );
  frame = Expanded(child: Center(child: frame));
  context.read(widgetProvider).state = frame;
}
