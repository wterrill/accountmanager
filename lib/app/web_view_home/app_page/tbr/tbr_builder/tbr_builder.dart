import 'package:accountmanager/models/question.dart';
import 'package:accountmanager/models/tbr.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/app/web_view_home/app_page/tbr/tbr_builder/bottom_arrows.dart';
import 'package:accountmanager/app/web_view_home/app_page/tbr/tbr_builder/drop_down_selectors.dart';
import 'package:accountmanager/app/web_view_home/app_page/tbr/tbr_builder/submit_button_row.dart';
import 'package:accountmanager/app/web_view_home/app_page/tbr/tbr_builder/tbr_evaluation_section.dart';
import 'package:accountmanager/app/web_view_home/app_page/tbr/tbr_builder/test_buttons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TBRbuilder extends StatefulWidget {
  const TBRbuilder({Key key, this.questionList}) : super(key: key);
  final List<Question> questionList;

  @override
  _TBRbuilderState createState() => _TBRbuilderState();
}

class TBRfillPageData {
  String selectedSection;
  String selectedCategory;
  List<Question> filteredQuestions;
}

final tbrFillPageDataProvider = StateProvider<TBRfillPageData>((ref) {
  return TBRfillPageData();
});

class _TBRbuilderState extends State<TBRbuilder> {
  // String selectedSection;
  // String selectedCategory;
  // List<Question> filteredQuestions;
  TBRinProgress tbrInProgress;
  TBRfillPageData tbrFillPageData;

  @override
  void initState() {
    tbrFillPageData = context.read(tbrFillPageDataProvider).state;
    tbrInProgress = context.read(tbrInProgressProvider).state;
    tbrInProgress.initialize(widget.questionList);
    tbrFillPageData.selectedSection = tbrInProgress.sections[1];
    tbrFillPageData.selectedCategory = tbrInProgress
        .categories[tbrFillPageData.selectedSection.toLowerCase()][0];
    tbrFillPageData.filteredQuestions = tbrInProgress.getQuestions(
        sectionIn: tbrFillPageData.selectedSection,
        categoryIn: tbrFillPageData.selectedCategory);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // List<TextEditingController>.generate(3, (TextEditingController index) => index * index);
    return Consumer(builder: (context, watch, child) {
      // List<String> beer = watch(tbrInProgressProvider).state.sections;
      // ignore: unused_local_variable
      final TBRinProgress beer2 = watch(tbrInProgressProvider).state;

      return Column(children: const [
        TestButtonRow(),
        SubmitButtonRow(),
        DropDownSelectors(),
        Expanded(child: TbrEvaluationSection()),
        BottomArrows(),
      ]);
    });
  }
}
