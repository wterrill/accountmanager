import 'package:accountmanager/app/web_view_home/overview/tbr_builder/bottom_arrows.dart';
import 'package:accountmanager/app/web_view_home/overview/tbr_builder/drop_down_selectors.dart';
import 'package:accountmanager/app/web_view_home/overview/tbr_builder/submit_button_row.dart';
import 'package:accountmanager/app/web_view_home/overview/tbr_builder/tbr_evaluation_section.dart';
import 'package:accountmanager/app/web_view_home/overview/tbr_builder/test_buttons.dart';
import 'package:accountmanager/models/question.dart';
import 'package:accountmanager/models/tbr.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TBRbuilder extends StatefulWidget {
  const TBRbuilder({Key? key, this.questionList}) : super(key: key);
  final List<Question>? questionList;

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
  // String selectedSection;
  // String selectedCategory;
  // List<Question> filteredQuestions;
  TBRinProgress? tbrInProgress;
  late TBRfillPageData tbrFillPageData;

  @override
  void initState() {
    tbrFillPageData = context.read(tbrFillPageDataProvider).state;
    tbrInProgress = context.read(tbrInProgressProvider).state;
    tbrInProgress!.initialize(widget.questionList);
    tbrFillPageData.selectedSection = tbrInProgress!.sections[1];
    tbrFillPageData.selectedCategory = tbrInProgress!
        .categories[tbrFillPageData.selectedSection!.toLowerCase()]![0];
    tbrFillPageData.filteredQuestions = tbrInProgress!.getQuestions(
        sectionIn: tbrFillPageData.selectedSection,
        categoryIn: tbrFillPageData.selectedCategory);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // List<TextEditingController>.generate(3, (TextEditingController index) => index * index);
    return Consumer(
        //ignore: avoid_types_on_closure_parameters, unnecessary_cast
        builder: (BuildContext context, ScopedReader watch, Widget? child) {
      // List<String> beer = watch(tbrInProgressProvider).state.sections;
      // ignore: unused_local_variable
      final TBRinProgress? thisIsJustToUpdateTheScreen =
          watch(tbrInProgressProvider).state;

      return Container(
        color: Colors.white70,
        child: Column(children: [
          const TestButtonRow(),
          const SubmitButtonRow(),
          const DropDownSelectors(),
          Expanded(child: TbrEvaluationSection()),
          const BottomArrows(),
        ]),
      );
    } as Widget Function(
            BuildContext, T Function<T>(ProviderBase<Object?, T>), Widget?));
  }
}
