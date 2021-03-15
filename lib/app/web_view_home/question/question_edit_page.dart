import 'package:accountmanager/common_widgets/display_widget_dialog_with_error.dart';
import 'package:accountmanager/app/web_view_home/question/create_data_table.dart';
import 'package:accountmanager/app/web_view_home/question/edit_question.dart';
import 'package:accountmanager/constants/strings.dart';
import 'package:flutter/material.dart';

class QuestionWebPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
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
    );
  }
}
