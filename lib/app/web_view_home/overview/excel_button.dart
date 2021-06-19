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
    return TextButton(
        onPressed: () {
          createExcel(tbrInProgress);
        },
        child: const Text('Create Excel'));
  }

  void createExcel(TBRinProgress completedTBR) {
    //Sheet1
    final Excel excel = Excel.createExcel();

    Sheet sheetObject = excel['Full TBR'];
    // Make Header Row
    List<String> headerList = [
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
    // print headers
    sheetObject.insertRowIterables(headerList, 0);

    // start printing rows
    for (var i = 0; i < headerList.length; i++) {
      final Data cell = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0));
      cell.cellStyle =
          CellStyle(backgroundColorHex: '#002244', underline: Underline.Double);
    }

    for (var row = 0; row < completedTBR.allQuestions!.length; row++) {
      final List<String?> temp = [];
      final String? id = tbrInProgress.allQuestions![row].id;
      // Write one single row
      temp.add(completedTBR.allQuestions![row].section);
      temp.add(completedTBR.allQuestions![row].category);
      temp.add(completedTBR.allQuestions![row].questionName);
      temp.add(completedTBR.allQuestions![row].questionPriority);
      temp.add(completedTBR.allQuestions![row].questionText);
      temp.add(getAlignment(completedTBR.answers![id]!,
          completedTBR.allQuestions![row].goodBadAnswer));
      temp.add(completedTBR.adminComment![id]);
      temp.add(completedTBR.tamNotes![id]);

      sheetObject.insertRowIterables(temp, row + 1);
      final Data cell = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: row));
      CellStyle cellStyle = CellStyle(backgroundColorHex: '#FFFFFF');
      switch (cell.value as String?) {
        case 'N':
          {
            cellStyle = CellStyle(backgroundColorHex: '#FF0000');
            break;
          }
        case 'Y':
          {
            cellStyle = CellStyle(backgroundColorHex: '#00FF00');
            break;
          }
        case 'N/A':
          {
            cellStyle = CellStyle(backgroundColorHex: '#555555');
            break;
          }
        case 'Aligned':
          cellStyle = CellStyle(backgroundColorHex: '#AAAAAA');
      }
      cell.cellStyle = cellStyle;
    }

// Sheet 2
    sheetObject = excel['Sheet2'];
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

    final List<int>? onValue = excel.encode(); //.then((onValue) {
    print(onValue);
    js.context.callMethod('webSaveAs', <dynamic>[
      html.Blob(<List<int>?>[onValue]),
      'test.xlsx'
    ]);
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
