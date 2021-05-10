// ignore_for_file: file_names
import 'package:accountmanager/app/web_view_home/assign_TBR/send_email_dialog.dart';
import 'package:accountmanager/common_utilities/buttonConverter.dart';
import 'package:accountmanager/app/web_view_home/assign_TBR/future_dropdown.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedantic/pedantic.dart';
import 'package:accountmanager/models/Status.dart';
import 'package:accountmanager/models/assigned_tbr.dart';
import 'package:accountmanager/models/company.dart';
import 'package:accountmanager/models/questionnaire_type.dart';
import 'package:accountmanager/models/technician.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/packages/alert_dialogs/alert_dialogs.dart';
import 'package:accountmanager/services/firestore_database.dart';

class AssignTBR extends StatefulWidget {
  const AssignTBR({
    Key? key,
    this.data,
  }) : super(key: key);
  final AssignedTBR? data;

  @override
  _AssignTBRState createState() => _AssignTBRState();
}

class _AssignTBRState extends State<AssignTBR> {
  Technician? selectedTechnician;
  Company? selectedCompany;
  QuestionnaireType? selectedQuestionnaireType;
  DateTime? evaluationDueDate;
  DateTime? clientMeetingDate;
  String? id;
  String? assignedBy;
  bool editAssignTBR = false;
  Status? status;
  Map<String, dynamic>? originalMap;
  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      selectedTechnician = widget.data!.technician;
      selectedCompany = widget.data!.company;
      selectedQuestionnaireType = widget.data!.questionnaireType;
      evaluationDueDate = widget.data!.dueDate;
      clientMeetingDate = widget.data!.clientMeetingDate;
      id = widget.data!.id;
      status = widget.data!.status;
      assignedBy = widget.data!.assignedBy;
      editAssignTBR = true;
      originalMap = createCurrentTBR(assignedBy).toMap();
    }
  }

  AssignedTBR createCurrentTBR(String? assignedBy) {
    return AssignedTBR(
        technician: selectedTechnician,
        company: selectedCompany,
        questionnaireType: selectedQuestionnaireType,
        clientMeetingDate: clientMeetingDate,
        dueDate: evaluationDueDate,
        status: status ??= Status(statusIndex: 0),
        assignedBy: assignedBy,
        id: id ??= documentIdFromCurrentDate());
  }

  bool? answer;

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = context.read(firebaseAuthProvider);
    final User? user = firebaseAuth.currentUser!;
    assignedBy ??= user?.email;
    final FirestoreDatabase? database = context.read(databaseProvider);
    return SizedBox(
      height: 320,
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // DropdownScreen(),
          FutureDropdown(
            hint: 'Choose a Technician:',
            selectedData: selectedTechnician,
            future: database!.technicianStream().first,
            onSelected: () {
              print('selected');
            },
            onSelectedChange: (dynamic tech) {
              setState(() {
                selectedTechnician = tech as Technician;
              });
            },
          ),
          // // Text(selectedTechnician?.name ?? 'Not selected'),
          FutureDropdown(
            hint: 'Choose a Company:',
            selectedData: selectedCompany,
            future: database.companyStream().first,
            onSelected: () {
              print('selected');
            },
            onSelectedChange: (dynamic company) {
              setState(() {
                selectedCompany = company as Company;
              });
            },
          ),
          // Text(selectedCompany?.name ?? 'Not selected'),
          FutureDropdown(
            hint: 'Choose a TBR type:',
            selectedData: selectedQuestionnaireType,
            future: database.questionnaireTypeStream().first,
            onSelected: () {
              print('selected');
            },
            onSelectedChange: (dynamic type) {
              setState(() {
                selectedQuestionnaireType = type as QuestionnaireType;
              });
            },
          ),
          // Text(selectedQuestionnaireType?.option ?? 'Not selected'),
          DateTimePicker(
            initialValue: evaluationDueDate.toString(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            dateLabelText: 'Evaluation Due Date',
            onChanged: (val) {
              print(val);
              setState(() {
                evaluationDueDate = DateTime.parse(val);
              });
            },
            validator: (val) {
              print(val);
              return null;
            },
            onSaved: (val) {
              print(val);
              setState(() {
                evaluationDueDate = DateTime.parse(val!);
              });
            },
          ),
          // Text(evaluationDueDate?.toString() ?? 'Not Selected'),
          DateTimePicker(
            initialValue: clientMeetingDate.toString(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            dateLabelText: 'Client Meeting Date',
            onChanged: (val) {
              print(val);
              setState(() {
                clientMeetingDate = DateTime.parse(val);
              });
            },
            validator: (val) {
              print(val);
              return null;
            },
            onSaved: (val) {
              print(val);
              setState(() {
                clientMeetingDate = DateTime.parse(val!);
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                FlatButtonX(
                  colorx: Colors.green,
                  childx: Text(
                    'Assign',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.blue[900],
                    ),
                  ),
                  onPressedx: () async {
                    bool valid = true;
                    AssignedTBR? assignedTbrForEmail;
                    while (valid) {
                      bool? validated;
                      validated = await _validateAndSaveForm(
                          createCurrentTBR(assignedBy));
                      if (validated == false) {
                        valid = false;
                        break;
                      }

                      if (validated! && widget.data == null) {
                        answer = true;
                      } else if (answer == null) {
                        answer = await showAlertDialog(
                          context: context,
                          title: 'Warning...',
                          content:
                              'This action will permanently overwrite data in the database.  Are you sure you want to proceed?',
                          cancelActionText: 'No',
                          defaultActionText: 'Yes',
                        );
                        print(answer);

                        if (!answer!) {
                          valid = false;
                        }
                      }
                      final AssignedTBR assignedTbr =
                          createCurrentTBR(assignedBy);

                      final bool notNullnotEditedOREditedAndChanged =
                          (!editAssignTBR && (assignedTbr.toMap() != null)) ||
                              (editAssignTBR &&
                                  (assignedTbr != null) &&
                                  !mapEquals<String, dynamic>(
                                      originalMap, assignedTbr.toMap()));
                      if (answer! //) {
                          &&
                          notNullnotEditedOREditedAndChanged) {
                        unawaited(_sendAssignedTbr(assignedTbr: assignedTbr));
                        valid = false;
                      }
                      assignedTbrForEmail = assignedTbr;
                    }
                    print('valid = $valid');

                    Navigator.of(context).pop();

                    await showWidgetDialog(
                        context: context,
                        title: 'Sent Email',
                        widget: SendEmailAssignDialog(
                            assignedTbr: assignedTbrForEmail));
                  },
                ),
                const Spacer(),
                FlatButtonX(
                    colorx: Colors.green,
                    childx: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.blue[900],
                      ),
                    ),
                    onPressedx: () => Navigator.of(context).pop()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _sendAssignedTbr({required AssignedTBR assignedTbr}) async {
    try {
      final database = context
          .read(databaseProvider as ProviderBase<Object?, FirestoreDatabase>);
      await database.setTBR(assignedTbr);
    } catch (e) {
      unawaited(showExceptionAlertDialog(
        context: context,
        title: 'Operation failed',
        exception: e,
      ));
    }
  }

  Future<bool?> _validateAndSaveForm(AssignedTBR assignedTbr) async {
    if (assignedTbr.toMap() == null) {
      return false;
    }
    bool? validated = true;
    while (validated == true) {
      if (assignedTbr.dueDate!.isBefore(DateTime.now())) {
        validated = await showAlertDialog(
            context: context,
            title: 'Are you sure?',
            content:
                'The due date is in the past, are you sure you want to proceed?',
            defaultActionText: 'Yes',
            cancelActionText: 'No');
        if (validated == false) break;
      }

      if (assignedTbr.clientMeetingDate!.isBefore(DateTime.now())) {
        validated = await showAlertDialog(
            context: context,
            title: 'Are you sure?',
            content:
                'The client meeting date is in the past, are you sure you want to proceed?',
            defaultActionText: 'Yes',
            cancelActionText: 'No');
        if (validated == false) break;
        //Condition should not unconditionally evalute to 'true' or to 'false'. verify:
      }

      if (assignedTbr.dueDate!.isAfter(assignedTbr.clientMeetingDate!)) {
        validated = await showAlertDialog(
            context: context,
            title: 'Are you sure?',
            content:
                'The due date is before the client meeting date, are you sure you want to proceed?',
            defaultActionText: 'Yes',
            cancelActionText: 'No');
        if (validated == false) break;
      }
      if (validated == true) break;
    }
    return validated;
  }
}
