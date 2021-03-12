import 'package:accountmanager/app/home/models/tbr.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/web_view_home/app_page/tbr/tbr_builder/tbr_builder.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';

class BottomArrows extends ConsumerWidget {
  const BottomArrows({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    TBRinProgress tbrInProgress = watch(tbrInProgressProvider).state;
    TBRfillPageData tbrFillPageData = watch(tbrFillPageDataProvider).state;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: FittedBox(
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                final Map<String, String> newSectionCategory =
                    tbrInProgress.recedePage(
                        section: tbrFillPageData.selectedSection,
                        category: tbrFillPageData.selectedCategory);

                tbrFillPageData.selectedSection = newSectionCategory['section'];
                tbrFillPageData.selectedCategory =
                    newSectionCategory['category'];
                tbrFillPageData.filteredQuestions = tbrInProgress.getQuestions(
                    sectionIn: tbrFillPageData.selectedSection,
                    categoryIn: tbrFillPageData.selectedCategory);

                context.read(tbrFillPageDataProvider).state = tbrFillPageData;
              },
            ),
          ),
        ),
        SizedBox(
          height: 100,
          width: 100,
          child: FittedBox(
            child: IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                final Map<String, String> newSectionCategory =
                    tbrInProgress.advancePage(
                        section: tbrFillPageData.selectedSection,
                        category: tbrFillPageData.selectedCategory);

                tbrFillPageData.selectedSection = newSectionCategory['section'];
                tbrFillPageData.selectedCategory =
                    newSectionCategory['category'];
                tbrFillPageData.filteredQuestions = tbrInProgress.getQuestions(
                    sectionIn: tbrFillPageData.selectedSection,
                    categoryIn: tbrFillPageData.selectedCategory);
                context.read(tbrFillPageDataProvider).state = tbrFillPageData;
              },
            ),
          ),
        )
      ],
    );
  }
}