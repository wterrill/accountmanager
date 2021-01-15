// import 'package:auditor/Definitions/Dialogs.dart';
// import 'package:auditor/Definitions/colorDefs.dart';
// import 'package:auditor/main.dart';
import 'package:accountmanager/app/home/models/assignedTbr.dart';
import 'package:accountmanager/constants/color_defs.dart';
import 'package:flutter/material.dart';
// import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';

import 'CustomDataTable.dart';
import 'CustomDataTableSource.dart';

class CalendarResultsDataSource extends CustomDataTableSource {
  final List<AssignedTBR> _calendarResults;
  CalendarResultsDataSource(this._calendarResults);

  void sort<T>(Comparable<T> getField(AssignedTBR d), bool ascending) {
    _calendarResults.sort((AssignedTBR a, AssignedTBR b) {
      if (!ascending) {
        final AssignedTBR c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  int _selectedCount = 0;

  @override
  CustomDataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _calendarResults.length) return null;
    final AssignedTBR calendarResult = _calendarResults[index];
    Color selectColor(String programType) {
      Color color = ColorDefs.colorAlternateLight;

      if (programType == "Healthy Student Market") {
        color = ColorDefs.colorAudit1;
      }
      if (programType == "Older Adults Program") {
        color = ColorDefs.colorAudit2;
      }
      if (programType == "Pantry") {
        color = ColorDefs.colorAudit3;
      }
      if (programType == "Congregate") {
        color = ColorDefs.colorAudit4;
      }
      return color;
    }

    return CustomDataRow.byIndex(
        index: index,
        selected: calendarResult.selected,
        onSelectChanged: (bool value) {
          print(value);
          print(calendarResult.company);
          // Dialogs.showAuditInfo(navigatorKey.currentState.overlay.context, calendarResult
          // );
        },
        cells: <CustomDataCell>[
          CustomDataCell(Container(
              height: double.infinity,
              width: double.infinity,
              color: index.isEven
                  ? ColorDefs.colorAlternatingDark
                  : ColorDefs.colorDarkBackground,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                  child: Text('${calendarResult.dueDate}',
                      style: ColorDefs.textBodyWhite15),
                ),
              ))),
          CustomDataCell(Container(
              height: double.infinity,
              width: double.infinity,
              color: index.isEven
                  ? ColorDefs.colorAlternatingDark
                  : ColorDefs.colorDarkBackground,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                  child: Text('${calendarResult.clientMeetingDate}',
                      style: ColorDefs.textBodyWhite15),
                ),
              ))),
          CustomDataCell(Container(
              height: double.infinity,
              width: double.infinity,
              color: index.isEven
                  ? ColorDefs.colorAlternatingDark
                  : ColorDefs.colorDarkBackground,
              child: Align(
                alignment: Alignment.centerLeft,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 225),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                    child: Text(calendarResult.company.name,
                        style: ColorDefs.textBodyWhite15,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
              ))),
          CustomDataCell(Container(
              height: double.infinity,
              width: double.infinity,
              color: index.isEven
                  ? ColorDefs.colorAlternatingDark
                  : ColorDefs.colorDarkBackground,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                  child: Text(calendarResult.technician.name,
                      style: ColorDefs.textBodyWhite15),
                ),
              ))),
          CustomDataCell(Container(
              height: double.infinity,
              width: double.infinity,
              color: index.isEven
                  ? ColorDefs.colorAlternatingDark
                  : ColorDefs.colorDarkBackground,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: selectColor(calendarResult.questionnaireType.name),
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                          width: 4.0, color: ColorDefs.colorLogoLightGreen)),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                      child: Text('${calendarResult.dueDate}',
                          style: ColorDefs.textBodyWhite15),
                    ),
                  ),
                ),
              ))),
          CustomDataCell(Container(
              height: double.infinity,
              width: double.infinity,
              color: index.isEven
                  ? ColorDefs.colorAlternatingDark
                  : ColorDefs.colorDarkBackground,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                    child: Text(calendarResult.technician.name,
                        style: ColorDefs.textBodyWhite15),
                  )))),
          CustomDataCell(Container(
              height: double.infinity,
              width: double.infinity,
              color: index.isEven
                  ? ColorDefs.colorAlternatingDark
                  : ColorDefs.colorDarkBackground,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                    child: Text('${calendarResult.status}',
                        style: ColorDefs.textBodyWhite15),
                  )))),
        ]);
  }

  @override
  int get rowCount => _calendarResults.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
