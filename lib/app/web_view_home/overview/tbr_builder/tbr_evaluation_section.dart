import 'package:accountmanager/app/web_view_home/overview/tbr_builder/super_tool_tip_widget.dart';
import 'package:accountmanager/app/web_view_home/overview/tbr_builder/tbr_builder.dart';
import 'package:accountmanager/models/question.dart';
import 'package:accountmanager/models/tbr.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/common_widgets/custom_toggle_buttons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TbrEvaluationSection extends ConsumerWidget {
  TbrEvaluationSection({Key? key}) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final TBRfillPageData tbrFillPageData =
        watch(tbrFillPageDataProvider).state;
    final TBRinProgress? tbrInProgress = watch(tbrInProgressProvider).state;
    return Scrollbar(
      controller: _scrollController,
      isAlwaysShown: true,
      child: ListView.builder(
        controller: _scrollController,
        shrinkWrap: false,
        // Let the ListView know how many items it needs to build.
        itemCount: tbrFillPageData.filteredQuestions.length,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
          final Question question = tbrFillPageData.filteredQuestions[index];
          // print('tbrInProgress.colorScheme: ${tbrInProgress.colorScheme}');
          final Map<String, List<Color?>> colorScheme =
              tbrInProgress!.colorScheme[question.id]!;

          // print('colorScheme: $colorScheme');
          // print('index: $index');
          // print('tbrInProgress.id ${tbrInProgress.allQuestions[index].id}');

          Color buttonColor(String priority) {
            Color returnedColor;
            switch (priority) {
              case 'low':
                {
                  returnedColor = Colors.green;
                }
                break;
              case 'medium':
                {
                  returnedColor = Colors.yellow;
                }
                break;
              case 'high':
                {
                  returnedColor = Colors.red;
                }
                break;
              default:
                returnedColor = Colors.grey;
            }
            return returnedColor;
          }

          return ExpansionTile(
            key: ObjectKey(question.id.toString()),
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                color: Colors.grey[100],
                child: Column(children: [
                  const Text('System Administrator Notes'),
                  TextField(
                    controller: TextEditingController(
                        text: tbrInProgress.adminComment![question.id]),
                    onChanged: (value) {
                      tbrInProgress.adminComment![question.id] = value;
                    },
                    minLines: 2,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      hintText: 'Put system administrator notes here...',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                    ),
                  ),
                  const Text('TAM Notes'),
                  TextField(
                    controller: TextEditingController(
                        text: tbrInProgress.tamNotes![question.id]),
                    onChanged: (value) {
                      tbrInProgress.tamNotes![question.id] = value;
                    },
                    minLines: 2,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      hintText: 'Put TAM Notes here...',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                    ),
                  ),
                ]),
              )
            ],
            initiallyExpanded: false,
            leading: Container(
              width: 100,
              child: Row(children: [
                // const Icon(Icons.help_outline),
                SuperToolTipWidget(
                  howString: question.howTo,
                  whyString: question.whyAreWeAsking,
                ),
                Tooltip(
                  message:
                      'Priority: ${tbrFillPageData.filteredQuestions[index].questionPriority}',
                  child: Icon(
                    Icons.brightness_1,
                    color: buttonColor(tbrFillPageData
                        .filteredQuestions[index].questionPriority!
                        .toLowerCase()),
                    size: 25,
                  ),
                )
              ]),
            ),
            title: Text(question.questionText!),
            subtitle: Text(question.questionName!),
            trailing: Container(
              width: 200,
              child: Row(
                children: [
                  const Icon(Icons.edit),
                  CustomToggleButtons(
                    children: const [Text('Yes'), Text('No'), Text('N/A')],
                    isSelected: tbrInProgress.answers![question.id]!,
                    onPressed: (index) {
                      print(index);
                      final List<bool> presentValue =
                          tbrInProgress.answers![question.id]!;
                      final List<bool> tempValue = [false, false, false];
                      // setState(() {
                      tempValue[index] = !presentValue[index];
                      tbrInProgress.answers![question.id] = tempValue;
                      tbrInProgress.updatePercentages();
                      context.read(tbrInProgressProvider).state = tbrInProgress;
                      // });
                    },
                    borderRadius: BorderRadius.circular(30),
                    borderWidth: 2,
                    borderColorList: colorScheme['borderColorList'],
                    selectedBorderColor: Colors.blue,
                    splashColor: Colors.blue,
                    // highlightColor: Colors.,
                    color: Colors.red,
                    selectedColorList: colorScheme['selectedColorList'],
                    fillColorList: colorScheme['fillColorList'],
                    renderBorder: true,
                    disabledColor: Colors.grey,
                    disabledBorderColor: Colors.grey,
                    hoverColorList: colorScheme['hoverColorList'],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
