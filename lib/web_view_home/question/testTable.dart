import 'package:flutter/material.dart';

class Testing extends StatefulWidget {
  Testing({Key key}) : super(key: key);

  @override
  _MyDataTableState createState() => _MyDataTableState();
}

class _MyDataTableState extends State<Testing> {
  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        //   appBar: AppBar(
        //     title: Text("DataTable"),
        //   ),
        //   body:
        // Row(
        //   children: <Widget>[
        //     //TODO: use Expanded here
        //     Expanded(
        //       child:
        //       SingleChildScrollView(
        //         padding: const EdgeInsets.all(8.0),
        //         child:
        DataTable(
      // columnSpacing: 100,
      columns: [
        DataColumn(
          label: Container(
            width: 100,
            child: Text('Item Code'),
          ),
        ),
        DataColumn(
          label: Text('Stock Item'),
        ),
      ],
      rows: [
        DataRow(
          cells: [
            DataCell(
              Text('Yup.  text.'),
            ),
            DataCell(
              Text(
                  'This is a really long text. It\'s supposed to be long so that I can figure out what in the hell is happening to the ability to have the text wrap in this datacell.  So far, I haven\'t been able to figure it out.'),
            )
          ],
        ),
      ],
    );
    //       ),
    //     ),
    //   ],
    // ),
    // );
  }
}
