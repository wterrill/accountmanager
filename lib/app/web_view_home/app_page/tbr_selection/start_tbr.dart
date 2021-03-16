import 'package:accountmanager/app/web_view_home/app_page/tbr_selection/create_tbr_select_datatable_widget.dart';
import 'package:accountmanager/models/company.dart';
import 'package:accountmanager/models/questionnaire_type.dart';
import 'package:accountmanager/models/technician.dart';
// import 'package:accountmanager/app/web_view_home/overview/create_overview_select_datatable_widget.dart';
import 'package:flutter/material.dart';

class SelectTBRPage extends StatefulWidget {
  final bool mobile;

  const SelectTBRPage({Key key, @required this.mobile}) : super(key: key);

  @override
  _SelectTBRPageState createState() => _SelectTBRPageState();
}

class _SelectTBRPageState extends State<SelectTBRPage> {
  Technician selectedTechnician;
  Company selectedCompany;
  QuestionnaireType selectedQuestionnaireType;
  DateTime startdateTBR;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final firebaseAuth = context.read(firebaseAuthProvider);
    // final user = firebaseAuth.currentUser;
    return Column(children: [
      CreateAppSelectDataTableWidget(mobile: widget.mobile),
    ]);
  }
}
