import 'package:flutter/material.dart';
// import 'dart:io';
import 'dart:js' as js;
import 'dart:html' as html;
// import 'dart:convert';
import 'package:docx_template/src/template.dart';
import 'package:docx_template/src/model.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CreateDocx(
          title:
              'MXOTech Account Manager placeholder page - Mike Beran, Will Terrill'),
    );
  }
}

class CreateDocx extends StatefulWidget {
  // required      Key?
  CreateDocx({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CreateDocxState createState() => _CreateDocxState();
}

class _CreateDocxState extends State<CreateDocx> {
  void _incrementCounter() async {
    final f = await rootBundle.load("assets/docx/template.docx");

    // final e = File("assets/docx/template.docx");
    // final docx = await DocxTemplate.fromBytes(await e.readAsBytes());

    final docx = await DocxTemplate.fromBytes(
        f.buffer.asUint8List(f.offsetInBytes, f.lengthInBytes));

    Content c = Content();
    String beer = "beer";
    c
      ..add(TextContent("docname", beer))
      ..add(TextContent("passport", "Passport NE0323 4456673"))
      ..add(TableContent("table", [
        RowContent()
          ..add(TextContent("key1", "Paul"))
          ..add(TextContent("key2", "Viberg"))
          ..add(TextContent("key3", "Engineer")),
        RowContent()
          ..add(TextContent("key1", "Alex"))
          ..add(TextContent("key2", "Houser"))
          ..add(TextContent("key3", "CEO & Founder"))
          ..add(ListContent("tablelist", [
            TextContent("value", "Mercedes-Benz C-Class S205"),
            TextContent("value", "Lexus LX 570")
          ]))
      ]))
      ..add(ListContent("list", [
        TextContent("value", "Engine")
          ..add(ListContent("listnested", [
            TextContent("value", "BMW M30"),
            TextContent("value", "2GZ GE")
          ])),
        TextContent("value", "Gearbox"),
        TextContent("value", "Chassis")
      ]))
      ..add(ListContent("plainlist", [
        PlainContent("plainview")
          ..add(TableContent("table", [
            RowContent()
              ..add(TextContent("key1", "Paul"))
              ..add(TextContent("key2", "Viberg"))
              ..add(TextContent("key3", "Engineer")),
            RowContent()
              ..add(TextContent("key1", "Alex"))
              ..add(TextContent("key2", "Houser"))
              ..add(TextContent("key3", "CEO & Founder"))
              ..add(ListContent("tablelist", [
                TextContent("value", "Mercedes-Benz C-Class S205"),
                TextContent("value", "Lexus LX 570")
              ]))
          ])),
        PlainContent("plainview")
          ..add(TableContent("table", [
            RowContent()
              ..add(TextContent("key1", "Nathan"))
              ..add(TextContent("key2", "Anceaux"))
              ..add(TextContent("key3", "Music artist"))
              ..add(ListContent(
                  "tablelist", [TextContent("value", "Peugeot 508")])),
            RowContent()
              ..add(TextContent("key1", "Louis"))
              ..add(TextContent("key2", "Houplain"))
              ..add(TextContent("key3", "Music artist"))
              ..add(ListContent("tablelist", [
                TextContent("value", "Range Rover Velar"),
                TextContent("value", "Lada Vesta SW Sport")
              ]))
          ])),
      ]))
      ..add(ListContent("multilineList", [
        PlainContent("multilinePlain")
          ..add(TextContent('multilineText', 'line 1')),
        PlainContent("multilinePlain")
          ..add(TextContent('multilineText', 'line 2')),
        PlainContent("multilinePlain")
          ..add(TextContent('multilineText', 'line 3'))
      ]))
      ..add(TextContent('multilineText2', 'line 1\nline 2\n line 3'));

    final d = await docx.generate(c);

    final script = html.document.createElement('script') as html.ScriptElement;
    // script.src = "http://cdn.jsdelivr.net/g/filesaver.js";
    script.src = "https://github.com/eligrey/FileSaver.js";

    html.document.body?.nodes.add(script);

// calls the "saveAs" method from the FileSaver.js libray
    // js.context.callMethod("saveAs", <dynamic>[
    //   html.Blob(bytes),
    //   "testText.txt", //File Name (optional) defaults to "download"
    //   "text/plain;charset=utf-8" //File Type (optional)
    // ]);

    js.context.callMethod("webSaveAs", <dynamic>[
      html.Blob(<List<int>>[d]),
      "Microsoft Word Test.docx"
    ]);

    // cleanup
    html.document.body?.nodes.remove(script);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Press the blue action button below to download a .docx file',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: Icon(Icons.add),
      ),
    );
  }
}
