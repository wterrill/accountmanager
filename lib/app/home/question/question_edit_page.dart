import 'dart:async';

import 'package:accountmanager/app/home/question/create_data_table.dart';
import 'package:accountmanager/app/home/question/edit_question.dart';
import 'package:accountmanager/app/home/question/testTable.dart';
import 'package:accountmanager/common_widgets/display_widget_dialog_with_error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/common_widgets/avatar.dart';
import 'package:accountmanager/constants/keys.dart';
import 'package:accountmanager/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:accountmanager/packages/alert_dialogs/alert_dialogs.dart';

class QuestionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.overview),
      ),
      body:
          // Testing()
          SingleChildScrollView(
        child: Column(children: [
          TextButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.green)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(Strings.questionStrings.createQuestion),
            ),
            onPressed: () {
              displayWidgetDialogWithError(context,
                  Strings.questionStrings.createQuestion, const EditQuestion());
            },
          ),
          //   //   Flexible(
          //   // child: SingleChildScrollView(
          //   //   child:
          //   // CreateDataTableWidget()
          //   Testing()
          CreateDataTableWidget(),
          Container(
            height: 100,
          )
        ]),
      ),
    );
  }
}
