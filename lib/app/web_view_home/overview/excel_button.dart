import 'package:accountmanager/app/top_level_providers.dart';
import 'package:universal_html/html.dart' as html;
import 'package:universal_html/js.dart' as js;
import 'package:accountmanager/models/tbr.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ExcelButton extends ConsumerWidget {
  const ExcelButton({Key? key, required this.tbrInProgress}) : super(key: key);
  final TBRinProgress tbrInProgress;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final Map<String, List<String>>? businessReasons =
        watch(latestBusinessReasonsProvider).state;
    return TextButton(
        onPressed: () {
          createExcel(tbrInProgress, businessReasons);
        },
        child: const Text('Create Excel'));
  }

  void createExcel(
      TBRinProgress completedTBR, Map<String, List<String>>? businessReasons) {
    List<String?> nullValues = [];
    //Sheet1
    final Excel excel = Excel.createExcel();

    Sheet sheetObject = excel['Full TBR'];
    // Make Header Row
    List<String> headerList = [
      '',
      'SECTION',
      'CATEGORY',
      'NAME',
      'PRIORITY',
      'QUESTION',
      'SUCCESS',
      'ADMIN NOTES',
      'TAM NOTES',
      'RECOMMENDATIONS',
      'COMPANY BENEFITS'
    ];
    const int headerRow = 2;
    const int columnOffset = 1;
    Data cellPointer;

//! TITLE - FULL TBR
    // print title
    sheetObject.insertRowIterables(<String>['', '', 'TBR: Full Evaluation'], 1);
    // styling for header
    cellPointer = sheetObject.cell(
        CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: headerRow - 1));
    cellPointer.cellStyle = CellStyle(
        // backgroundColorHex: '#002244',
        underline: Underline.Double,
        fontColorHex: '#000000',
        fontSize: 20);

//! HEADERS - FULL TBR
    // print headers
    sheetObject.insertRowIterables(headerList, headerRow);

    // header style
    for (var i = 1; i < headerList.length + 1; i++) {
      final Data cell = sheetObject.cell(
          CellIndex.indexByColumnRow(columnIndex: i, rowIndex: headerRow));
      cell.cellStyle = CellStyle(
          backgroundColorHex: '#002244',
          underline: Underline.Double,
          fontColorHex: '#FFFFFF');
    }

//! DATA - FULL TBR
    for (var row = 0; row < completedTBR.allQuestions!.length; row++) {
      // const int offset = 3;
      // final int row = rowIndex + offset;
      final List<String?> temp = [];
      final String? id = tbrInProgress.allQuestions![row].id;
      // Write one single row, starting with the blank columns
      for (int i = 0; i < columnOffset; i++) {
        temp.add('');
      }

      // grey section column

      cellPointer = sheetObject.cell(CellIndex.indexByColumnRow(
          columnIndex: columnOffset, rowIndex: row + headerRow + 1));
      cellPointer.cellStyle = CellStyle(backgroundColorHex: '#D8D8D8');
// lighter grey category column
      cellPointer = sheetObject.cell(CellIndex.indexByColumnRow(
          columnIndex: columnOffset + 1, rowIndex: row + headerRow + 1));
      cellPointer.cellStyle = CellStyle(backgroundColorHex: '#F2F2F2');

// fill in data
      temp.add(completedTBR.allQuestions![row].section);
      temp.add(completedTBR.allQuestions![row].category);
      temp.add(completedTBR.allQuestions![row].questionName);
      temp.add(completedTBR.allQuestions![row].questionPriority);
      temp.add(completedTBR.allQuestions![row].questionText);
      temp.add(getAlignment(completedTBR.answers![id]!,
          completedTBR.allQuestions![row].goodBadAnswer));
      temp.add(completedTBR.adminComment![id]);
      temp.add(completedTBR.tamNotes![id]);

      sheetObject.insertRowIterables(temp, row + headerRow + 1);
      cellPointer = sheetObject.cell(CellIndex.indexByColumnRow(
          columnIndex: 6, rowIndex: row + headerRow + 1));
      //! Styling for SUCCESS COL
      CellStyle cellStyle = CellStyle(backgroundColorHex: '#FFFFFF');
      switch (cellPointer.value as String?) {
        case 'N':
          {
            cellStyle = CellStyle(
                backgroundColorHex: '#FF0000',
                fontColorHex: '#FFFFFF',
                horizontalAlign: HorizontalAlign.Center);
            sheetObject.cell(CellIndex.indexByColumnRow(
                columnIndex: 7, rowIndex: row + headerRow + 1));
            print(completedTBR.allQuestions![row].projectType);
            cellPointer.value = completedTBR.allQuestions![row].projectType;
            sheetObject.cell(CellIndex.indexByColumnRow(
                columnIndex: 8, rowIndex: row + headerRow + 1));
            String updatedName =
                completedTBR.allQuestions![row].projectType!.toLowerCase();
            updatedName = updatedName.replaceAll('/', '_');
            print(updatedName);
            print(businessReasons![updatedName]);
            if (businessReasons[updatedName] == null) {
              nullValues.add(completedTBR.allQuestions![row].projectType);
              print(completedTBR.allQuestions![row].projectType);
            }
            cellPointer.value = businessReasons[updatedName];

            break;
          }
        case 'Y':
          {
            cellStyle = CellStyle(
                backgroundColorHex: '#34A853',
                fontColorHex: '#FFFFFF',
                horizontalAlign: HorizontalAlign.Center);
            break;
          }
        case 'N/A':
          {
            cellStyle = CellStyle(
                backgroundColorHex: '#555555',
                fontColorHex: '#FFFFFF',
                horizontalAlign: HorizontalAlign.Center);
            break;
          }
        case 'SUCCESS':
          cellStyle = CellStyle(backgroundColorHex: '#AAAAAA');
      }
      cellPointer.cellStyle = cellStyle;
    }

    print(nullValues);

//! SCORECARD
//! tally data
    sheetObject = excel['SCORECARD'];
    int yes = 0;
    int no = 0;
    int na = 0;
    for (var i = 0; i < completedTBR.allQuestions!.length; i++) {
      final String? id = completedTBR.allQuestions![i].id;
      if (completedTBR.answers![id].toString() ==
          [true, false, false].toString()) {
        yes++;
      }
      if (completedTBR.answers![id].toString() ==
          [false, true, false].toString()) {
        no++;
      }
      if (completedTBR.answers![id].toString() ==
          [false, false, true].toString()) {
        na++;
      }
    }

//! Header
    headerList = [
      'Number of Yes',
      'Number of No',
      'Number of N/A',
      'Total answers'
    ];

    // print headers
    sheetObject.insertRowIterables(headerList, 0);
    List<String> temp = [];
    temp.add(yes.toString());
    temp.add(no.toString());
    temp.add(na.toString());
    temp.add((yes + no + na).toString());
    sheetObject.insertRowIterables(temp, 1);
    temp = [];
    final int total = yes + no + na;
    temp.add('${(yes * 100 / total).toStringAsFixed(2)}%');
    temp.add('${(no * 100 / total).toStringAsFixed(2)}%');
    temp.add('${(na * 100 / total).toStringAsFixed(2)}%');
    sheetObject.insertRowIterables(temp, 2);

    // get rid of default sheet
    excel.delete('Sheet1');

    final List<int>? onValue = excel.encode(); //.then((onValue) {
    print(onValue);
    js.context.callMethod('webSaveAs', <dynamic>[
      html.Blob(<List<int>?>[onValue]),
      'test.xlsx'
    ]);

    //     final Data cell = sheetObject
    //     .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: 0));
    // cell.value = 'beer';

    // final CellStyle cellStyle = CellStyle(
    //     backgroundColorHex: '#1AFF1A',
    //     fontFamily: getFontFamily(FontFamily.Calibri));

    // cellStyle.underline = Underline.Single; // or Underline.Double

    // final Data cell = sheetObject.cell(CellIndex.indexByString('A1'));
    // cell.value =
    //     'WHERE IN THE WORLD IS CARMEN SAN DIEGO??'; // dynamic values support provided;
    // cell.cellStyle = cellStyle;

    // File(outputFile)
    //   // File(join(outputFile))
    //   // ..createSync(recursive: true)
    //   ..writeAsBytesSync(onValue);
    // print('yup');
    //  }
    // );

    // const String file = '/Users/kawal/Desktop/form.xlsx';
    // Uint8List bytes = File(file).readAsBytesSync();
    // final Excel excel = Excel.createExcel();
    // // or
    // //var excel = Excel.decodeBytes(bytes);
    // for (final String table in excel.tables.keys) {
    //   print(table);
    //   print(excel.tables[table].maxCols);
    //   print(excel.tables[table].maxRows);
    //   for (final List<dynamic> row in excel.tables[table].rows) {
    //     print('$row');
    //   }
    // }

    // CellStyle cellStyle = CellStyle(
    //   bold: true,
    //   italic: true,
    //   fontFamily: getFontFamily(FontFamily.Comic_Sans_MS),
    // );

    // Excel sheet = excel['mySheet'];

    // var cell = sheet.cell(CellIndex.indexByString('A1'));
    // cell.value = 'Heya How are you I am fine ok goood night';
    // cell.cellStyle = cellStyle;

    // var cell2 = sheet.cell(CellIndex.indexByString('E5'));
    // cell2.value = 'Heya How night';
    // cell2.cellStyle = cellStyle;

    // /// printing cell-type
    // print('CellType: ' + cell.cellType.toString());

    // /// Iterating and changing values to desired type
    // for (int row = 0; row < sheet.maxRows; row++) {
    //   sheet.row(row).forEach((cell) {
    //     var val = cell.value; //  Value stored in the particular cell

    //     cell.value = ' My custom Value ';
    //   });
    // }

    // excel.rename('mySheet', 'myRenamedNewSheet');

    // // fromSheet should exist in order to sucessfully copy the contents
    // excel.copy('myRenamedNewSheet', 'toSheet');

    // excel.rename('oldSheetName', 'newSheetName');

    // excel.delete('Sheet1');

    // excel.unLink('sheet1');

    // sheet = excel['sheet'];

    // /// appending rows
    // List<List<String>> list = List.generate(
    //     6000, (index) => List.generate(20, (index1) => '$index $index1'));

    // Stopwatch stopwatch = new Stopwatch()..start();
    // list.forEach((row) {
    //   sheet.appendRow(row);
    // });

    // print('doSomething() executed in ${stopwatch.elapsed}');

    // sheet.appendRow([8]);
    // excel.setDefaultSheet(sheet.sheetName).then((isSet) {
    //   // isSet is bool which tells that whether the setting of default sheet is successful or not.
    //   if (isSet) {
    //     print('${sheet.sheetName} is set to default sheet.');
    //   } else {
    //     print('Unable to set ${sheet.sheetName} to default sheet.');
    //   }
    // });

    // // Saving the file

    // String outputFile = '/Users/kawal/Desktop/form1.xlsx';
    // excel.encode().then((onValue) {
    //   File(join(outputFile))
    //     ..createSync(recursive: true)
    //     ..writeAsBytesSync(onValue);
    // });
  }
}

String getAlignment(List<bool> answerArray, String? expected) {
  print(answerArray);
  print(expected);
  if (!answerArray.contains(true)) {
    return '';
  }
  if (answerArray[1] == true && expected == 'N = Bad') {
    return 'N';
  } else if (answerArray[2] == true) {
    return 'N/A';
  } else {
    return 'Y';
  }
}
