import 'package:accountmanager/app/web_view_home/assign_TBR/create_tbr_assign_datatable_widget.dart';
import 'package:accountmanager/models/company.dart';
import 'package:accountmanager/models/questionnaire_type.dart';
import 'package:accountmanager/models/technician.dart';
import 'package:accountmanager/common_widgets/display_widget_dialog_with_error.dart';
import 'package:accountmanager/app/web_view_home/assign_TBR/widget_assign_TBR2.dart';
import 'package:accountmanager/constants/strings.dart';
import 'package:flutter/material.dart';

class AssignTBRWebPage extends StatefulWidget {
  @override
  _AssignTBRWebPageState createState() => _AssignTBRWebPageState();
}

class _AssignTBRWebPageState extends State<AssignTBRWebPage> {
  Technician? selectedTechnician;
  Company? selectedCompany;
  QuestionnaireType? selectedQuestionnaireType;
  DateTime? startdateTBR;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final firebaseAuth = context.read(firebaseAuthProvider);
    // final user = firebaseAuth.currentUser;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
          child: TextButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.green)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(Strings.tbrStrings.assignTbr),
            ),
            onPressed: () {
              displayWidgetDialogWithError(
                  context, Strings.tbrStrings.assignTbr, const AssignTBR());
            },
          ),
        ),
        CreateTBRAssignDataTableWidget()
      ],
    );
  }
}
