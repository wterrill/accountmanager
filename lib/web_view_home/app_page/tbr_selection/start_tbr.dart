import 'package:accountmanager/app/models/company.dart';
import 'package:accountmanager/app/models/questionnaire_type.dart';
import 'package:accountmanager/app/models/technician.dart';
import 'package:accountmanager/web_view_home/overview/create_datatable_widget2.dart';
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
      CreateOverviewSelectDataTableWidget(mobile: widget.mobile),
    ]);
  }
}
