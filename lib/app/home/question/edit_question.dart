import 'package:accountmanager/app/home/models/question.dart';
import 'package:accountmanager/app/home/question/dropdown_screen.dart';
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

import '../models/assignedTbr.dart';

class EditQuestion extends StatefulWidget {
  const EditQuestion({
    Key key,
    this.data,
  }) : super(key: key);
  final Question data;

  @override
  _EditQuestionState createState() => _EditQuestionState();
}

class _EditQuestionState extends State<EditQuestion> {
  String benefitsBusinessValue;
  String category;
  String customerApprovedProject;
  String estimatedLaborPrice;
  String estimatedMRRIncrease;
  String estimatedProductPrice;
  String howTo;
  String projectType;
  String questionName;
  String questionPriority;
  String questionText;
  String roadMap; //mm/yyyy
  String section;
  String sysAdminNotes;
  bool sysAdminReviewAligned;
  String tamRecommendations;
  String tamReview;
  String totalProjectEstimate;
  String type;
  String whyAreWeAsking;
  String id;
  bool editQuestion = false;
  Map<String, dynamic> originalMap;
  String _name;
  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      benefitsBusinessValue = widget.data.benefitsBusinessValue;
      category = widget.data.category;
      customerApprovedProject = widget.data.customerApprovedProject;
      estimatedLaborPrice = widget.data.estimatedLaborPrice;
      estimatedMRRIncrease = widget.data.estimatedMRRIncrease;
      estimatedProductPrice = widget.data.estimatedProductPrice;
      howTo = widget.data.howTo;
      projectType = widget.data.projectType;
      questionName = widget.data.questionName;
      questionPriority = widget.data.questionPriority;
      questionText = widget.data.questionText;
      roadMap = widget.data.roadMap; //mm/yyyy
      section = widget.data.section;
      sysAdminNotes = widget.data.sysAdminNotes;
      sysAdminReviewAligned = widget.data.sysAdminReviewAligned;
      tamRecommendations = widget.data.tamRecommendations;
      tamReview = widget.data.tamReview;
      totalProjectEstimate = widget.data.totalProjectEstimate;
      type = widget.data.type;
      whyAreWeAsking = widget.data.whyAreWeAsking;
      id = widget.data.id;
      editQuestion = true;
      originalMap = createCurrentQuestion().toMap();
    }
  }

  Question createCurrentQuestion() {
    return Question(
        id: id,
        benefitsBusinessValue: benefitsBusinessValue,
        category: category,
        customerApprovedProject: customerApprovedProject,
        estimatedLaborPrice: estimatedLaborPrice,
        estimatedMRRIncrease: estimatedMRRIncrease,
        estimatedProductPrice: estimatedProductPrice,
        howTo: howTo,
        projectType: projectType,
        questionName: questionName,
        questionPriority: questionPriority,
        questionText: questionText,
        roadMap: roadMap, //mm/yyyy
        section: section,
        sysAdminNotes: sysAdminNotes,
        sysAdminReviewAligned: sysAdminReviewAligned,
        tamRecommendations: tamRecommendations,
        tamReview: tamReview,
        totalProjectEstimate: totalProjectEstimate,
        type: type,
        whyAreWeAsking: whyAreWeAsking);
  }

  @override
  Widget build(BuildContext context) {
    final FirestoreDatabase database = context.read(databaseProvider);
    return FractionallySizedBox(
      heightFactor: 0.6,
      child: Column(
        children: [
          Text("test"),
          DropdownScreen(),
          TextField(
            autocorrect: true,
            enableSuggestions: true,
            keyboardType: TextInputType.text,
            maxLength: 50,
            controller: TextEditingController(text: _name),
            decoration: const InputDecoration(
              labelText: 'Name',
              labelStyle:
                  TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
            keyboardAppearance: Brightness.light,
            style: const TextStyle(fontSize: 20.0, color: Colors.black),
            onChanged: (inputName) => _name = inputName,
          ),

          // DropdownScreen(),
          // FutureDropdown(
          //   hint: 'Choose a Technician:',
          //   selectedData: selectedTechnician,
          //   future: database.technicianStream().first,
          //   onSelected: () {
          //     print('selected');
          //   },
          //   onSelectedChange: (dynamic tech) {
          //     print(tech.toString());
          //     setState(() {
          //       selectedTechnician = tech as Technician;
          //     });
          //   },
          // ),
          // // Text(selectedTechnician?.name ?? 'Not selected'),
          // FutureDropdown(
          //   hint: 'Choose a Company:',
          //   selectedData: selectedCompany,
          //   future: database.companyStream().first,
          //   onSelected: () {
          //     print('selected');
          //   },
          //   onSelectedChange: (dynamic company) {
          //     print(company.toString());
          //     setState(() {
          //       selectedCompany = company as Company;
          //     });
          //   },
          // ),
          // // Text(selectedCompany?.name ?? 'Not selected'),
          // FutureDropdown(
          //   hint: 'Choose a TBR type:',
          //   selectedData: selectedQuestionnaireType,
          //   future: database.questionnaireTypeStream().first,
          //   onSelected: () {
          //     print('selected');
          //   },
          //   onSelectedChange: (dynamic type) {
          //     print(type.toString());
          //     setState(() {
          //       selectedQuestionnaireType = type as QuestionnaireType;
          //     });
          //   },
          // ),
          // // Text(selectedQuestionnaireType?.option ?? 'Not selected'),
          // DateTimePicker(
          //   initialValue: evaluationDueDate.toString(),
          //   firstDate: DateTime(2000),
          //   lastDate: DateTime(2100),
          //   dateLabelText: 'Evaluation Due Date',
          //   onChanged: (val) {
          //     print(val);
          //     setState(() {
          //       evaluationDueDate = DateTime.parse(val);
          //     });
          //   },
          //   validator: (val) {
          //     print(val);
          //     return null;
          //   },
          //   onSaved: (val) {
          //     print(val);
          //     setState(() {
          //       evaluationDueDate = DateTime.parse(val);
          //     });
          //   },
          // ),
          // // Text(evaluationDueDate?.toString() ?? 'Not Selected'),
          // DateTimePicker(
          //   initialValue: clientMeetingDate.toString(),
          //   firstDate: DateTime(2000),
          //   lastDate: DateTime(2100),
          //   dateLabelText: 'Client Meeting Date',
          //   onChanged: (val) {
          //     print(val);
          //     setState(() {
          //       clientMeetingDate = DateTime.parse(val);
          //     });
          //   },
          //   validator: (val) {
          //     print(val);
          //     return null;
          //   },
          //   onSaved: (val) {
          //     print(val);
          //     setState(() {
          //       clientMeetingDate = DateTime.parse(val);
          //     });
          //   },
          // ),
          // FlatButton(
          //   child: const Text(
          //     'Assign',
          //     style: TextStyle(
          //       fontSize: 18.0,
          //       color: Colors.blue,
          //     ),
          //   ),
          //   onPressed: () async {
          //     bool valid = true;
          //     while (valid) {
          //       bool validated;
          //       validated = await _validateAndSaveForm(createCurrentQuestion());
          //       if (validated == false) {
          //         valid = false;
          //         break;
          //       }
          //       bool answer = false;
          //       if (validated && widget.data == null) {
          //         answer = true;
          //       } else {
          //         answer = await showAlertDialog(
          //           context: context,
          //           title: 'Warning...',
          //           content:
          //               'This action will permanently overwrite data in the database.  Are you sure you want to proceed?',
          //           cancelActionText: 'No',
          //           defaultActionText: 'Yes',
          //         );
          //       }
          //       final AssignedTBR assignedTbr = createCurrentQuestion();

          //       final bool notNullnotEditedOREditedAndChanged =
          //           (!editAssignTBR && (assignedTbr.toMap() != null)) ||
          //               (editAssignTBR &&
          //                   (assignedTbr != null) &&
          //                   !mapEquals<String, dynamic>(
          //                       originalMap, assignedTbr.toMap()));
          //       if (answer //) {
          //           &&
          //           notNullnotEditedOREditedAndChanged) {
          //         unawaited(_sendAssignedTbr(assignedTbr: assignedTbr));
          //       }
          //     }
          //     print('valid = $valid');

          //     Navigator.of(context).pop();
          //   },
          // ),
          // const Spacer(),
          // FlatButton(
          //     child: const Text(
          //       'Cancel',
          //       style: TextStyle(
          //         fontSize: 18.0,
          //         color: Colors.blue,
          //       ),
          //     ),
          //     onPressed: () => Navigator.of(context).pop()),
          // Text(clientMeetingDate?.toString() ?? 'Not Selected')
        ],
      ),
    );
  }

  Future<void> _sendAssignedTbr({@required AssignedTBR assignedTbr}) async {
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

  Future<bool> _validateAndSaveForm(AssignedTBR assignedTbr) async {
    if (assignedTbr.toMap() == null) {
      return false;
    }
    bool answer = true;
    while (answer == true) {
      if (assignedTbr.dueDate.isBefore(DateTime.now())) {
        answer = await showAlertDialog(
            context: context,
            title: 'Are you sure?',
            content:
                'The due date is in the past, are you sure you want to proceed?',
            defaultActionText: 'Yes',
            cancelActionText: 'No');
        if (answer == false) break;
      }

      if (assignedTbr.clientMeetingDate.isBefore(DateTime.now())) {
        answer = await showAlertDialog(
            context: context,
            title: 'Are you sure?',
            content:
                'The client meeting date is in the past, are you sure you want to proceed?',
            defaultActionText: 'Yes',
            cancelActionText: 'No');
        if (answer == false) break;
        //Condition should not unconditionally evalute to 'true' or to 'false'. verify:
      }

      if (assignedTbr.dueDate.isBefore(assignedTbr.clientMeetingDate)) {
        answer = await showAlertDialog(
            context: context,
            title: 'Are you sure?',
            content:
                'The due date is before the client meeting date, are you sure you want to proceed?',
            defaultActionText: 'Yes',
            cancelActionText: 'No');
        if (answer == false) break;
      }
      if (answer == true) break;
    }
    return answer;
  }
}
