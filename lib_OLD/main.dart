import 'package:accountmanager/pages/developerSection/CreateDocx.dart';
import 'package:accountmanager/pages/developerSection/auth/AuthExampleApp.dart';
import 'package:accountmanager/widgets/auth_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'dart:io';
// import 'dart:js' as js;
// import 'dart:html' as html;
// import 'dart:convert';
// import 'package:docx_template/src/template.dart';
// import 'package:docx_template/src/model.dart';
// import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'appLogic/models/user.dart';
import 'appLogic/services/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

void main() {
  // void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // runApp(MyApp());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Container(
        child: FlatButton(
            onPressed: () {
              showDialog<Widget>(
                context: context,
                builder: (BuildContext context) => AuthDialog(),
              );
            },
            child: Text("press")),
      ),
    );
  }
}
