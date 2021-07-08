import 'package:accountmanager/app/web_view_home/assign_TBR/widget_assign_TBR_dialog.dart';
import 'package:accountmanager/app/web_view_home/home/home_page.dart';
import 'package:accountmanager/app/web_view_home/overview/tbr_builder/bottom_arrows.dart';
import 'package:accountmanager/app/web_view_home/overview/tbr_builder/drop_down_selectors.dart';
import 'package:accountmanager/app/web_view_home/overview/tbr_builder/save_button_row.dart';
import 'package:accountmanager/app/web_view_home/overview/tbr_builder/submit_button_row.dart';
import 'package:accountmanager/app/web_view_home/overview/tbr_builder/tbr_evaluation_section.dart';
import 'package:accountmanager/app/web_view_home/overview/tbr_builder/test_buttons.dart';
import 'package:accountmanager/app/web_view_home/overview/tbr_builder/total_percentage_row.dart';
import 'package:accountmanager/main.dart';
import 'package:accountmanager/models/assigned_tbr.dart';
import 'package:accountmanager/models/question.dart';
import 'package:accountmanager/models/tbr_in_progress.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hive/hive.dart';

class TBRbuilder extends StatefulWidget {
  const TBRbuilder({Key? key, this.questionList, this.displayTBR})
      : super(key: key);
  final List<Question>? questionList;
  final TBRinProgress? displayTBR;

  @override
  _TBRbuilderState createState() => _TBRbuilderState();
}

class TBRfillPageData {
  String? selectedSection;
  String? selectedCategory;
  late List<Question> filteredQuestions;
}

final tbrFillPageDataProvider = StateProvider<TBRfillPageData>((ref) {
  return TBRfillPageData();
});

class _TBRbuilderState extends State<TBRbuilder> {
  TBRinProgress? tbrInProgress;
  late TBRfillPageData tbrFillPageData;
  AssignedTBR? assignedTbr;
  // late Future<Box<TBRinProgress>> futureBoxTBRinProgress;

  @override
  void initState() {
    // globalBoxTBRinProgress.deleteAll(globalBoxTBRinProgress.keys);
    tbrFillPageData = context.read(tbrFillPageDataProvider).state;
    tbrInProgress = context.read(tbrInProgressProvider).state;
    assignedTbr = context.read(assignedTbrProvider).state;
    if (assignedTbr?.id != null) {
      if (globalBoxTBRinProgress.get(assignedTbr!.id) != null) {
        tbrInProgress = globalBoxTBRinProgress.get(assignedTbr!.id);
      }
    }
    if (widget.displayTBR == null && (tbrInProgress?.id != assignedTbr?.id)) {
      tbrInProgress!.initialize(widget.questionList, assignedTbr!.id);
      tbrFillPageData.selectedSection = tbrInProgress!.sections[1];
      tbrFillPageData.selectedCategory = tbrInProgress!
          .categories[tbrFillPageData.selectedSection!.toLowerCase()]![0];
      tbrFillPageData.filteredQuestions = tbrInProgress!.getQuestions(
          sectionIn: tbrFillPageData.selectedSection,
          categoryIn: tbrFillPageData.selectedCategory);
    } else {
      tbrFillPageData = context.read(tbrFillPageDataProvider).state;
      tbrInProgress = context.read(tbrInProgressProvider).state;
      // tbrInProgress!.initialize(widget.questionList);
      tbrFillPageData.selectedSection = tbrInProgress!.sections[1];
      tbrFillPageData.selectedCategory = tbrInProgress!
          .categories[tbrFillPageData.selectedSection!.toLowerCase()]![0];
      tbrFillPageData.filteredQuestions = tbrInProgress!.getQuestions(
          sectionIn: tbrFillPageData.selectedSection,
          categoryIn: tbrFillPageData.selectedCategory);
      tbrInProgress!.updatePercentages();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // globalBoxTBRinProgress.put(tbrInProgress!.id, tbrInProgress!);
    // List<TextEditingController>.generate(3, (TextEditingController index) => index * index);
    return Consumer(

        //ignore: avoid_types_on_closure_parameters, unnecessary_cast
        builder: (BuildContext context, ScopedReader watch, Widget? child) {
      globalBoxTBRinProgress.put(tbrInProgress!.id, tbrInProgress!);

      // globalBoxTBRinProgress.deleteAll(globalBoxTBRinProgress.keys);

      // context.read(boxTBRInProgressProvider).state = boxTBRinProgress;

      // List<String> beer = watch(tbrInProgressProvider).state.sections;
      // ignore: unused_local_variable
      final TBRinProgress? thisIsJustToUpdateTheScreen =
          watch(tbrInProgressProvider).state;

      return Container(
        color: Colors.white70,
        child: Column(children: [
          const TestButtonRow(),
          // const SaveButtonRow(),
          const TotalPercentageRow(),
          const DropDownSelectors(),
          Expanded(
            child: TbrEvaluationSection(),
          ),
          const BottomArrows(),
        ]),
      );
    } as Widget Function(
            BuildContext, T Function<T>(ProviderBase<Object?, T>), Widget?));
  }
}
