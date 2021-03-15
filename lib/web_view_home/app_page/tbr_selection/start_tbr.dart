// import 'dart:async';
// import 'package:accountmanager/web_view_home/app_page/tbr_selection/create_datatable_widget2.dart';
import 'package:accountmanager/app/home/models/company.dart';
import 'package:accountmanager/app/home/models/questionnaire_type.dart';
import 'package:accountmanager/app/home/models/technician.dart';
// import 'package:accountmanager/common_widgets/display_widget_dialog_with_error.dart';
import 'package:accountmanager/web_view_home/overview/create_datatable_widget2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:accountmanager/app/top_level_providers.dart';
// import 'package:accountmanager/constants/strings.dart';
import 'package:flutter/material.dart';

// import 'package:accountmanager/packages/alert_dialogs/alert_dialogs.dart';
import 'package:flutter_riverpod/all.dart';

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
    final firebaseAuth = context.read(firebaseAuthProvider);
    final user = firebaseAuth.currentUser;
    return Column(children: [
      CreateOverviewSelectDataTableWidget(mobile: widget.mobile),
    ]);
  }
}
