import 'package:accountmanager/models/question.dart';
import 'package:accountmanager/common_widgets/annotated_editable_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EditQuestion extends StatefulWidget {
  const EditQuestion({
    Key? key,
    this.data,
  }) : super(key: key);
  final Question? data;

  @override
  _EditQuestionState createState() => _EditQuestionState();
}

class _EditQuestionState extends State<EditQuestion> {
  String? benefitsBusinessValue;
  String? category;
  String? customerApprovedProject;
  String? estimatedLaborPrice;
  String? estimatedMRRIncrease;
  String? estimatedProductPrice;
  String? howTo;
  String? projectType;
  String? questionName;
  String? questionPriority;
  String? questionText;
  String? roadMap; //mm/yyyy
  String? section;
  String? sysAdminNotes;
  bool? sysAdminReviewAligned;
  String? goodBadAnswer;
  String? tamRecommendations;
  String? tamReview;
  String? totalProjectEstimate;
  String? type;
  String? whyAreWeAsking;
  String? id;
  bool editQuestion = false;
  Map<String, dynamic>? originalMap;

  FocusNode? myFocusNode;

  final TextEditingController _benefitsBusinessValueC = TextEditingController();
  final TextEditingController _categoryC = TextEditingController();
  final TextEditingController _customerApprovedProjectC =
      TextEditingController();
  final TextEditingController _estimatedLaborPriceC = TextEditingController();
  final TextEditingController _estimatedMRRIncreaseC = TextEditingController();
  final TextEditingController _estimatedProductPriceC = TextEditingController();
  final TextEditingController _howToC = TextEditingController();
  final TextEditingController _projectTypeC = TextEditingController();
  final TextEditingController _questionNameC = TextEditingController();
  final TextEditingController _questionPriorityC = TextEditingController();
  final TextEditingController _questionTextC = TextEditingController();
  final TextEditingController _roadMapC = TextEditingController();
  final TextEditingController _sectionC = TextEditingController();
  final TextEditingController _sysAdminNotesC = TextEditingController();
  final TextEditingController _sysAdminReviewAlignedC = TextEditingController();
  final TextEditingController _goodBadAnswerC = TextEditingController();
  final TextEditingController _tamRecommendationsC = TextEditingController();
  final TextEditingController _tamReviewC = TextEditingController();
  final TextEditingController _totalProjectEstimateC = TextEditingController();
  final TextEditingController _typeC = TextEditingController();
  final TextEditingController _whyAreWeAskingC = TextEditingController();

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(myFocusNode);
    });
    if (widget.data != null) {
      benefitsBusinessValue = widget.data!.benefitsBusinessValue;

      category = widget.data!.category;

      customerApprovedProject = widget.data!.customerApprovedProject;

      estimatedLaborPrice = widget.data!.estimatedLaborPrice;

      estimatedMRRIncrease = widget.data!.estimatedMRRIncrease;

      estimatedProductPrice = widget.data!.estimatedProductPrice;

      howTo = widget.data!.howTo;

      projectType = widget.data!.projectType;

      questionName = widget.data!.questionName;

      questionPriority = widget.data!.questionPriority;

      questionText = widget.data!.questionText;

      roadMap = widget.data!.roadMap; //mm/yyyy

      section = widget.data!.section;

      sysAdminNotes = widget.data!.sysAdminNotes;

      sysAdminReviewAligned = widget.data!.sysAdminReviewAligned;

      goodBadAnswer = widget.data!.goodBadAnswer;

      tamRecommendations = widget.data!.tamRecommendations;

      tamReview = widget.data!.tamReview;

      totalProjectEstimate = widget.data!.totalProjectEstimate;

      type = widget.data!.type;

      whyAreWeAsking = widget.data!.whyAreWeAsking;

      id = widget.data!.id;
      editQuestion = true;
      originalMap = createCurrentQuestion().toMap();

      _benefitsBusinessValueC.text = benefitsBusinessValue!;
      _categoryC.text = category!;
      _customerApprovedProjectC.text = customerApprovedProject!;
      _estimatedLaborPriceC.text = estimatedLaborPrice!;
      _estimatedMRRIncreaseC.text = estimatedMRRIncrease!;
      _estimatedProductPriceC.text = estimatedProductPrice!;
      _howToC.text = howTo!;
      _projectTypeC.text = projectType!;
      _questionNameC.text = questionName!;
      _questionPriorityC.text = questionPriority!;
      _questionTextC.text = questionText!;
      _roadMapC.text = roadMap!;
      _sectionC.text = section!;
      _sysAdminNotesC.text = sysAdminNotes!;
      _sysAdminReviewAlignedC.text = sysAdminReviewAligned.toString();
      _goodBadAnswerC.text = goodBadAnswer!;
      _tamRecommendationsC.text = tamRecommendations!;
      _tamReviewC.text = tamReview!;
      _totalProjectEstimateC.text = totalProjectEstimate!;
      _typeC.text = type!;
      _whyAreWeAskingC.text = whyAreWeAsking!;
    } else {
      _benefitsBusinessValueC.text = 'in progress';
      _categoryC.text = 'in progress';
      _customerApprovedProjectC.text = 'in progress';
      _estimatedLaborPriceC.text = 'in progress';
      _estimatedMRRIncreaseC.text = 'in progress';
      _estimatedProductPriceC.text = 'in progress';
      _howToC.text = 'in progress';
      _projectTypeC.text = 'in progress';
      _questionNameC.text = 'in progress';
      _questionPriorityC.text = 'in progress';
      _questionTextC.text = 'in progress';
      _roadMapC.text = 'in progress';
      _sectionC.text = 'in progress';
      _sysAdminNotesC.text = 'in progress';
      _sysAdminReviewAlignedC.text = 'in progress';
      _goodBadAnswerC.text = 'in progress';
      _tamRecommendationsC.text = 'in progress';
      _tamReviewC.text = 'in progress';
      _totalProjectEstimateC.text = 'in progress';
      _typeC.text = 'in progress';
      _whyAreWeAskingC.text = 'in progress';
    }
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode!.dispose();

    super.dispose();
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
        goodBadAnswer: goodBadAnswer,
        tamRecommendations: tamRecommendations,
        tamReview: tamReview,
        totalProjectEstimate: totalProjectEstimate,
        type: type,
        whyAreWeAsking: whyAreWeAsking);
  }

  @override
  Widget build(BuildContext context) {
    final List<Annotation> annotations = [
      Annotation(
          range: const TextRange(start: 3, end: 10),
          style: const TextStyle(
              fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.red)),
      Annotation(
          range: const TextRange(start: 18, end: 30),
          style: const TextStyle(
              fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.blue)),
    ];
    // final FirestoreDatabase database = context.read(databaseProvider);
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // DropdownScreen(),
            AnnotatedEditableText(
              // Key key,
              focusNode: myFocusNode!,
              controller: _questionTextC,
              style:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
              onChanged: (yup) {
                print(yup);
                print(yup.runtimeType);
              },
              onSubmitted: (also) {
                print(also);
                print(also.runtimeType);
              },
              cursorColor: Colors.blue,
              selectionColor: Colors.green,
              // selectionControls:,
              annotations: annotations,
            ),

            generateTextInput(_categoryC, 'Category'),
            generateTextInput(_benefitsBusinessValueC, 'Benefits Bus. Value'),
            generateTextInput(_projectTypeC, 'Project Type'),
            generateTextInput(_questionNameC, 'Question Name'),
            generateTextInput(_questionPriorityC, 'Question Priority'),
            generateTextInput(_questionTextC, 'Question Text'),
            generateTextInput(_sectionC, 'Section'),
            generateTextInput(_whyAreWeAskingC, 'Why are we asking?'),
            generateTextInput(
                _customerApprovedProjectC, 'Customer Approved Project'),
            generateTextInput(_estimatedLaborPriceC, 'Estimated Labor Price'),
            generateTextInput(_estimatedMRRIncreaseC, 'Estimated MRR Increase'),
            generateTextInput(
                _estimatedProductPriceC, 'Estimated Product Price'),
            generateTextInput(_howToC, 'How To?'),

            generateTextInput(_roadMapC, 'Road Map'),
            generateTextInput(_sysAdminNotesC, 'Sys Admin Notes'),
            generateTextInput(
                _sysAdminReviewAlignedC, 'Sys Admin Review Aligned'),
            generateTextInput(_goodBadAnswerC, 'Good / Bad Answer'),
            generateTextInput(_tamRecommendationsC, 'TAM Recommendations'),
            generateTextInput(_tamReviewC, 'TAM Review'),
            generateTextInput(_totalProjectEstimateC, 'Total Project Estimate'),
            generateTextInput(_typeC, 'Type'),

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
      ),
    );
  }

  Widget generateTextInput(TextEditingController controller, String label,
      [int? maxLength]) {
    maxLength ??= 50;
    return TextField(
      autocorrect: true,
      enableSuggestions: true,
      keyboardType: TextInputType.text,
      maxLength: maxLength,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle:
            const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      ),
      keyboardAppearance: Brightness.light,
      style: const TextStyle(fontSize: 20.0, color: Colors.black),
      onChanged: (inputName) => controller.text = inputName,
    );
  }

  // Future<void> _sendAssignedTbr({@required AssignedTBR assignedTbr}) async {
  //   try {
  //     id ??= documentIdFromCurrentDate();
  //     final database = context.read(databaseProvider);
  //     await database.setTBR(assignedTbr);
  //   } catch (e) {
  //     unawaited(showExceptionAlertDialog(
  //       context: context,
  //       title: 'Operation failed',
  //       exception: e,
  //     ));
  //   }
  // }

  // Future<bool> _validateAndSaveForm(AssignedTBR assignedTbr) async {
  //   if (assignedTbr.toMap() == null) {
  //     return false;
  //   }
  //   bool answer = true;
  //   while (answer == true) {
  //     if (assignedTbr.dueDate.isBefore(DateTime.now())) {
  //       answer = await showAlertDialog(
  //           context: context,
  //           title: 'Are you sure?',
  //           content:
  //               'The due date is in the past, are you sure you want to proceed?',
  //           defaultActionText: 'Yes',
  //           cancelActionText: 'No');
  //       if (answer == false) break;
  //     }

  //     if (assignedTbr.clientMeetingDate.isBefore(DateTime.now())) {
  //       answer = await showAlertDialog(
  //           context: context,
  //           title: 'Are you sure?',
  //           content:
  //               'The client meeting date is in the past, are you sure you want to proceed?',
  //           defaultActionText: 'Yes',
  //           cancelActionText: 'No');
  //       if (answer == false) break;
  //       //Condition should not unconditionally evalute to 'true' or to 'false'. verify:
  //     }

  //     if (assignedTbr.dueDate.isBefore(assignedTbr.clientMeetingDate)) {
  //       answer = await showAlertDialog(
  //           context: context,
  //           title: 'Are you sure?',
  //           content:
  //               'The due date is before the client meeting date, are you sure you want to proceed?',
  //           defaultActionText: 'Yes',
  //           cancelActionText: 'No');
  //       if (answer == false) break;
  //     }
  //     if (answer == true) break;
  //   }
  //   return answer;
  // }
}
