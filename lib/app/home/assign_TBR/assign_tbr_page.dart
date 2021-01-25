import 'dart:async';

import 'package:accountmanager/app/home/assign_TBR/create_datatable_widget2.dart';
// import 'package:accountmanager/app/home/assign_TBR/dropdown_screen.dart';
// import 'package:accountmanager/app/home/assign_TBR/future_dropdown.dart';
import 'package:accountmanager/app/home/assign_TBR/widget_assign_TBR2.dart';
// import 'package:accountmanager/app/home/models/assignedTbr.dart';
import 'package:accountmanager/app/home/models/company.dart';
import 'package:accountmanager/app/home/models/questionnaire_type.dart';
import 'package:accountmanager/app/home/models/technician.dart';
import 'package:accountmanager/common_widgets/display_widget_dialog_with_error.dart';
// import 'package:accountmanager/services/firestore_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/common_widgets/avatar.dart';
import 'package:accountmanager/constants/keys.dart';
import 'package:accountmanager/constants/strings.dart';
import 'package:flutter/material.dart';

import 'package:accountmanager/packages/alert_dialogs/alert_dialogs.dart';
import 'assigned_tbr_data_table.dart';
import 'package:flutter_riverpod/all.dart';
import '../../top_level_providers.dart';

class AssignTBRPage extends StatefulWidget {
  @override
  _AssignTBRPageState createState() => _AssignTBRPageState();
}

class _AssignTBRPageState extends State<AssignTBRPage> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.tbrStrings.assignTbr),
        // bottom: PreferredSize(
        //   preferredSize: const Size.fromHeight(130.0),
        //   child: _buildUserInfo(user),
        // ),
      ),
      body: Column(
        children: [
          TextButton(
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
          CreateDataTableWidget()
        ],
      ),
    );
  }
}
