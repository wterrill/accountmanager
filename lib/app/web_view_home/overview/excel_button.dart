import 'dart:io';
// import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:excel/excel.dart';
// import 'package:path/path.dart';

class ExcelButton extends ConsumerWidget {
  const ExcelButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return TextButton(
        onPressed: () {
          print('create excel');
          createExcel(['beer']);
        },
        child: const Text('Create Excel'));
  }

  void createExcel(List<String> args) {
    final Excel excel = Excel.createExcel();

    final Sheet sheetObject = excel['SheetName'];

    final CellStyle cellStyle = CellStyle(
        backgroundColorHex: '#1AFF1A',
        fontFamily: getFontFamily(FontFamily.Calibri));

    cellStyle.underline = Underline.Single; // or Underline.Double

    final Data cell = sheetObject.cell(CellIndex.indexByString('A1'));
    cell.value =
        'WHERE IN THE WORLD IS CARMEN SAN DIEGO??'; // dynamic values support provided;
    cell.cellStyle = cellStyle;

    // printing cell-type
    // print('CellType:   ${cell.cellType}');

    ///
    /// Inserting and removing column and rows

    // insert column at index = 8
    // sheetObject.insertColumn(8);

    // // remove column at index = 18
    // sheetObject.removeColumn(18);

    // // insert row at index = 82
    // sheetObject.removeRow(82);

    // // remove row at index = 80
    // sheetObject.removeRow(80);

    final List<String> dataList = [
      'Google',
      'loves',
      'Flutter',
      'and',
      'Flutter',
      'loves',
      'Google'
    ];

    sheetObject.insertRowIterables(dataList, 8);

    const String outputFile = '/Users/williamterrill/Desktop/form1.xlsx';
    excel.encode().then((onValue) {
      File(outputFile)
        // File(join(outputFile))
        ..createSync(recursive: true)
        ..writeAsBytesSync(onValue);
      print('yup');
    });

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
