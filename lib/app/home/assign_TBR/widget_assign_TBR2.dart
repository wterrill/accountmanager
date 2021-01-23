import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedantic/pedantic.dart';

import 'package:accountmanager/app/home/assign_TBR/future_dropdown.dart';
import 'package:accountmanager/app/home/models/Status.dart';
import 'package:accountmanager/app/home/models/assignedTbr.dart';
import 'package:accountmanager/app/home/models/company.dart';
import 'package:accountmanager/app/home/models/questionnaire_type.dart';
import 'package:accountmanager/app/home/models/technician.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/packages/alert_dialogs/alert_dialogs.dart';
import 'package:accountmanager/services/firestore_database.dart';

class AssignTBR extends StatefulWidget {
  const AssignTBR({
    Key key,
    this.data,
  }) : super(key: key);
  final AssignedTBR data;

  @override
  _AssignTBRState createState() => _AssignTBRState();
}

class _AssignTBRState extends State<AssignTBR> {
  Technician selectedTechnician;
  Company selectedCompany;
  QuestionnaireType selectedQuestionnaireType;
  DateTime evaluationDueDate;
  DateTime clientMeetingDate;
  String id;
  bool editAssignTBR = false;
  Status status;
  Map<String, dynamic> originalMap;
  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      selectedTechnician = widget.data.technician;
      selectedCompany = widget.data.company;
      selectedQuestionnaireType = widget.data.questionnaireType;
      evaluationDueDate = widget.data.dueDate;
      clientMeetingDate = widget.data.clientMeetingDate;
      id = widget.data.id;
      status = widget.data.status;
      editAssignTBR = true;
      originalMap = createCurrentTBR().toMap();
    }
  }

  AssignedTBR createCurrentTBR() {
    return AssignedTBR(
        id: id,
        technician: selectedTechnician,
        company: selectedCompany,
        questionnaireType: selectedQuestionnaireType,
        clientMeetingDate: clientMeetingDate,
        dueDate: evaluationDueDate,
        status: status ??= Status(statusIndex: 0));
  }

  @override
  Widget build(BuildContext context) {
    final FirestoreDatabase database = context.read(databaseProvider);
    return FractionallySizedBox(
      heightFactor: 0.6,
      child: Column(
        children: [
          // DropdownScreen(),
          FutureDropdown(
            selectedData: selectedTechnician,
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
          // Text(selectedTechnician?.name ?? 'Not selected'),
          FutureDropdown(
            selectedData: selectedCompany,
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
          // Text(selectedCompany?.name ?? 'Not selected'),
          FutureDropdown(
            selectedData: selectedQuestionnaireType,
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
                evaluationDueDate = DateTime.parse(val);
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
                clientMeetingDate = DateTime.parse(val);
              });
            },
          ),
          FlatButton(
            child: const Text(
              'Assign',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.blue,
              ),
            ),
            onPressed: () async {
              bool answer = true;
              if (widget.data == null) {
                answer = false;
              } else {
                answer = await showAlertDialog(
                  context: context,
                  title: 'Warning...',
                  content:
                      'This action will permanently overwrite data in the database.  Are you sure you want to proceed?',
                  cancelActionText: 'No',
                  defaultActionText: 'Yes',
                );
              }
              final AssignedTBR assignedTbr = createCurrentTBR();

              final bool notEditedOREditedAndChanged = !editAssignTBR ||
                  (editAssignTBR &&
                      !mapEquals<String, dynamic>(
                          originalMap, assignedTbr.toMap()));
              // // const bool notEditedOREditedAndChanged = false;
              if (answer //) {
                  &&
                  notEditedOREditedAndChanged) {
                unawaited(_sendAssignedTbr(assignedTbr: assignedTbr));
              }

              Navigator.of(context).pop();
            },
          ),
          const Spacer(),
          FlatButton(
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.blue,
                ),
              ),
              onPressed: () => Navigator.of(context).pop()),
          // Text(clientMeetingDate?.toString() ?? 'Not Selected')
        ],
      ),
    );
  }

  Future<void> _sendAssignedTbr({@required AssignedTBR assignedTbr}) async {
    if (_validateAndSaveForm()) {
      try {
        id ??= documentIdFromCurrentDate();
        final database = context.read(databaseProvider);
        await database.setTBR(assignedTbr);
      } catch (e) {
        unawaited(showExceptionAlertDialog(
          context: context,
          title: 'Operation failed',
          exception: e,
        ));
      }
    }
  }

  bool _validateAndSaveForm() {
    return true;
  }
}
