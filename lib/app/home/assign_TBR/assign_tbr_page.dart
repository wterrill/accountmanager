import 'dart:async';

import 'package:accountmanager/app/home/assign_TBR/dropdown_screen.dart';
import 'package:accountmanager/app/home/assign_TBR/future_dropdown.dart';
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
import 'package:date_time_picker/date_time_picker.dart';

final companyStreamProvider = StreamProvider.autoDispose<List<Company>>((ref) {
  final database = ref.watch(databaseProvider);
  return database?.companyStream() ?? const Stream.empty();
});

final technicianStreamProvider =
    StreamProvider.autoDispose<List<Technician>>((ref) {
  final database = ref.watch(databaseProvider);
  return database?.technicianStream() ?? const Stream.empty();
});

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

  Future<void> _signOut(BuildContext context, FirebaseAuth firebaseAuth) async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      unawaited(showExceptionAlertDialog(
        context: context,
        title: Strings.logoutFailed,
        exception: e,
      ));
    }
  }

  Future<void> _confirmSignOut(
      BuildContext context, FirebaseAuth firebaseAuth) async {
    final bool didRequestSignOut = await showAlertDialog(
          context: context,
          title: Strings.logout,
          content: Strings.logoutAreYouSure,
          cancelActionText: Strings.cancel,
          defaultActionText: Strings.logout,
        ) ??
        false;
    if (didRequestSignOut == true) {
      await _signOut(context, firebaseAuth);
    }
  }

  @override
  Widget build(BuildContext context) {
    final FirestoreDatabase database = context.read(databaseProvider);
    // final technicianNOTSURE = await database.technicianStream().first;
    final firebaseAuth = context.read(firebaseAuthProvider);
    final user = firebaseAuth.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.assignTbr),
        actions: <Widget>[
          FlatButton(
            key: const Key(Keys.logout),
            child: const Text(
              Strings.logout,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: () => _confirmSignOut(context, firebaseAuth),
          ),
        ],
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
            // style: TextButton.styleFrom(backgroundColor: Colors.red),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Show Dialog'),
            ),

            onPressed: () {
              print('pressed');
              _displayDialog(context);
            },
          ),
          DropdownScreen(),
          FutureDropdown(
            future: database.technicianStream().first,
            onSelected: () {
              print('selected');
            },
            onSelectedChange: (dynamic tech) {
              print(tech.toString());
              setState(() {
                selectedTechnician = tech as Technician;
              });
            },
          ),
          Text(selectedTechnician?.name ?? 'Not selected'),
          FutureDropdown(
            future: database.companyStream().first,
            onSelected: () {
              print('selected');
            },
            onSelectedChange: (dynamic company) {
              print(company.toString());
              setState(() {
                selectedCompany = company as Company;
              });
            },
          ),
          Text(selectedCompany?.name ?? 'Not selected'),
          FutureDropdown(
            future: database.questionnaireTypeStream().first,
            onSelected: () {
              print('selected');
            },
            onSelectedChange: (dynamic type) {
              print(type.toString());
              setState(() {
                selectedQuestionnaireType = type as QuestionnaireType;
              });
            },
          ),
          Text(selectedQuestionnaireType?.option ?? 'Not selected'),
          DateTimePicker(
            initialValue: '',
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            dateLabelText: 'Date',
            onChanged: (val) {
              print(val);
              setState(() {
                startdateTBR = DateTime.parse(val);
              });
            },
            validator: (val) {
              print(val);
              return null;
            },
            onSaved: (val) {
              print(val);
              setState(() {
                startdateTBR = DateTime.parse(val);
              });
            },
          ),
          Text(startdateTBR?.toString() ?? 'Not Selected')
          // DateTimePicker(
          //   type: DateTimePickerType.time,
          //   initialValue: '',
          //   // firstDate: DateTime(2000),
          //   // lastDate: DateTime(2100),
          //   timeLabelText: 'Time',
          //   onChanged: (val) => print(val),
          //   validator: (val) {
          //     print(val);
          //     return null;
          //   },
          //   onSaved: (val) => print(val),
          // )
        ],
      ),
    );
  }

  Future<void> _displayDialog(BuildContext context) async {
    try {
      final Map<String, dynamic> result = await showWidgetDialog(
        context: context,
        title: 'Assign TBR',
        widget: Container(
            width: 400, color: Colors.pink, child: const Text('hello')),
        defaultActionText: 'Cancel',
        cancelActionText: 'Assign',
      );

      if (result != null && (result['result']) == 'true') {
        print('result = $result');
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
