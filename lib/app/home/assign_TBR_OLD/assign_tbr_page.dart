import 'dart:async';

import 'package:accountmanager/app/home/assign_TBR_OLD/dropdown_screen.dart';
import 'package:accountmanager/app/home/assign_TBR_OLD/future_dropdown.dart';
import 'package:accountmanager/app/home/assign_TBR_OLD/test1.dart';
import 'package:accountmanager/app/home/assign_TBR_OLD/test2.dart';
import 'package:accountmanager/app/home/assign_TBR_OLD/widget_assign_tbr.dart';
import 'package:accountmanager/app/home/models/assignedTbr.dart';
import 'package:accountmanager/app/home/models/company.dart';
import 'package:accountmanager/app/home/models/questionnaire_type.dart';
import 'package:accountmanager/app/home/models/technician.dart';
import 'package:accountmanager/services/firestore_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/common_widgets/avatar.dart';
import 'package:accountmanager/constants/keys.dart';
import 'package:accountmanager/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:accountmanager/packages/alert_dialogs/alert_dialogs.dart';
import 'assigned_tbr_data_table.dart';
import 'package:flutter_riverpod/all.dart';
import '../../top_level_providers.dart';

// final companyStreamProvider = StreamProvider.autoDispose<List<Company>>((ref) {
//   final database = ref.watch(databaseProvider);
//   return database?.companyStream() ?? const Stream.empty();
// });

// final technicianStreamProvider =
//     StreamProvider.autoDispose<List<Technician>>((ref) {
//   final database = ref.watch(databaseProvider);
//   return database?.technicianStream() ?? const Stream.empty();
// });

final assignedTbrStreamProvider =
    StreamProvider.autoDispose<List<AssignedTBR>>((ref) {
  final database = ref.watch(databaseProvider);
  return database?.assignedTbrStream() ?? const Stream.empty();
});

class AssignTBRPage_OLD extends StatefulWidget {
  @override
  _AssignTBRPage_OLDState createState() => _AssignTBRPage_OLDState();
}

class _AssignTBRPage_OLDState extends State<AssignTBRPage_OLD> {
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
        title: const Text(Strings.assignTbr_OLD),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(130.0),
          child: _buildUserInfo(user),
        ),
      ),
      body: Column(
        children: [
          TextButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.green)),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Assign TBR'),
            ),
            onPressed: () {
              _displayDialog(context);
            },
          ),
          const IpaginatedTable()
          // Test1()
          // Test2()
          // DataTableBuilderConsumer<AssignedTBR>(
          //     inputStreamProvider: assignedTbrStreamProvider)
        ],
      ),
    );
  }

  Future<void> _displayDialog(BuildContext context) async {
    try {
      final Map<String, dynamic> result = await showWidgetDialog(
        context: context,
        title: 'Assign TBR',
        widget: const AssignTBR(),
        // defaultActionText: '',
        // cancelActionText: '',
      );

      if (result != null && (result['result']) == 'true') {
        // print('result = $result');
      }
    } catch (e) {
      unawaited(showExceptionAlertDialog(
        context: context,
        title: 'Operation failed',
        exception: e,
      ));
    }
  }

  Widget _buildUserInfo(User user) {
    return Column(
      children: [
        Avatar(
          photoUrl: user.photoURL,
          radius: 50,
          borderColor: Colors.black54,
          borderWidth: 2.0,
        ),
        const SizedBox(height: 8),
        if (user.displayName != null)
          Text(
            user.displayName,
            style: const TextStyle(color: Colors.white),
          ),
        const SizedBox(height: 8),
      ],
    );
  }
}
