import 'package:accountmanager/app/home/assign_tbr/dropdown_screen.dart';
import 'package:accountmanager/app/home/assign_TBR/future_dropdown.dart';
import 'package:accountmanager/app/home/models/assignedTbr.dart';
import 'package:accountmanager/app/home/models/company.dart';
import 'package:accountmanager/app/home/models/questionnaire_type.dart';
import 'package:accountmanager/app/home/models/technician.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/packages/alert_dialogs/alert_dialogs.dart';
import 'package:accountmanager/services/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:pedantic/pedantic.dart';

class AssignTBR extends StatefulWidget {
  const AssignTBR({Key key}) : super(key: key);

  @override
  _AssignTBRState createState() => _AssignTBRState();
}

class _AssignTBRState extends State<AssignTBR> {
  Technician selectedTechnician;
  Company selectedCompany;
  QuestionnaireType selectedQuestionnaireType;
  DateTime evaluationDueDate;
  DateTime clientMeetingDate;
  @override
  Widget build(BuildContext context) {
    final FirestoreDatabase database = context.read(databaseProvider);
    return FractionallySizedBox(
      heightFactor: 0.6,
      child: Column(
        children: [
          // DropdownScreen(),
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
          // Text(selectedTechnician?.name ?? 'Not selected'),
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
          // Text(selectedCompany?.name ?? 'Not selected'),
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
          // Text(selectedQuestionnaireType?.option ?? 'Not selected'),
          DateTimePicker(
            initialValue: '',
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
            initialValue: '',
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
              onPressed: () => {
                    (_sendAssignedTbr(
                        selectedTechnician: selectedTechnician,
                        selectedCompany: selectedCompany,
                        selectedQuestionnaireType: selectedQuestionnaireType,
                        evaluationDueDate: evaluationDueDate,
                        clientMeetingDate: clientMeetingDate))
                  }),
          const Spacer(),
          FlatButton(
              child: Text(
                'Cancel',
                style: const TextStyle(
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

  Future<void> _sendAssignedTbr(
      {Technician selectedTechnician,
      Company selectedCompany,
      QuestionnaireType selectedQuestionnaireType,
      DateTime evaluationDueDate,
      DateTime clientMeetingDate}) async {
    print(selectedTechnician);
    print(selectedCompany);
    print(selectedQuestionnaireType);
    print(evaluationDueDate);
    print(clientMeetingDate);
    if (_validateAndSaveForm()) {
      try {
        final database = context.read(databaseProvider);
        final id = documentIdFromCurrentDate();
        final assignedTbr = AssignedTBR(
            id: id,
            technician: selectedTechnician,
            company: selectedCompany,
            questionnaireType: selectedQuestionnaireType,
            clientMeetingDate: clientMeetingDate,
            dueDate: evaluationDueDate,
            status: 0);
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
