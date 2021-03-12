import 'package:accountmanager/app/home/models/tbr.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/web_view_home/app_page/tbr/tbr_builder/tbr_builder.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DropDownSelectors extends ConsumerWidget {
  const DropDownSelectors({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final TBRinProgress tbrInProgress = watch(tbrInProgressProvider).state;
    final TBRfillPageData tbrFillPageData =
        watch(tbrFillPageDataProvider).state;

    return Column(
      children: [
        DropdownButton(
          // dropdownColor: Colors.amber,
          hint: Text(
              '${tbrFillPageData.selectedSection} : ${(tbrInProgress.percentages[tbrFillPageData.selectedSection.toLowerCase()]['total'] * 100).toStringAsFixed(0)}%'),
          items: tbrInProgress.sections.map((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Container(
                // color: Colors.brown[200],
                // width: 300,
                child: Text(
                    '$value : ${(tbrInProgress.percentages[value.toLowerCase()]['total'] * 100).toStringAsFixed(0)}%'),
              ),
            );
          }).toList(),
          // ignore: avoid_types_on_closure_parameters
          onChanged: (String value) {
            print(value);
            tbrFillPageData.selectedSection = value;
            tbrFillPageData.selectedCategory = tbrInProgress
                .categories[tbrFillPageData.selectedSection.toLowerCase()][0];
            tbrFillPageData.filteredQuestions = tbrInProgress.getQuestions(
                sectionIn: tbrFillPageData.selectedSection,
                categoryIn: tbrFillPageData.selectedCategory);
            context.read(tbrFillPageDataProvider).state = tbrFillPageData;
          },
        ),
        // Category DropDown
        DropdownButton(
          hint: Text(
              '${tbrFillPageData.selectedCategory} : ${(tbrInProgress.percentages[tbrFillPageData.selectedSection.toLowerCase()][tbrFillPageData.selectedCategory.toLowerCase()] * 100).toStringAsFixed(0)}%'),
          items: tbrInProgress
              .categories[tbrFillPageData.selectedSection.toLowerCase()]
              .map((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                  '$value : ${(tbrInProgress.percentages[tbrFillPageData.selectedSection.toLowerCase()][value.toLowerCase()] * 100).toStringAsFixed(0)}%'),
            );
          }).toList(),
          // ignore: avoid_types_on_closure_parameters
          onChanged: (String value) {
            print(value);
            tbrFillPageData.selectedCategory = value;
            tbrFillPageData.filteredQuestions = tbrInProgress.getQuestions(
                sectionIn: tbrFillPageData.selectedSection,
                categoryIn: tbrFillPageData.selectedCategory);

            context.read(tbrFillPageDataProvider).state = tbrFillPageData;
          },
        ),
      ],
    );
  }
}
