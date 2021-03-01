import 'package:accountmanager/app/home/models/question.dart';
import 'package:accountmanager/app/home/models/tbr.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/common_widgets/custom_toggle_buttons.dart';
import 'package:accountmanager/web_view_home/app_page/tbr/tbr_builder/super_tool_tip_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math';

class TBRbuilder extends StatefulWidget {
  const TBRbuilder({Key key, this.questionList}) : super(key: key);
  final List<Question> questionList;

  @override
  _TBRbuilderState createState() => _TBRbuilderState();
}

class _TBRbuilderState extends State<TBRbuilder> {
  String selectedSection;
  String selectedCategory;
  List<Question> filteredQuestions;
  TBRinProgress tbrInProgress;

  @override
  void initState() {
    tbrInProgress = context.read(tbrInProgressProvider);
    tbrInProgress.initialize(widget.questionList);
    selectedSection = tbrInProgress.sections[1];
    selectedCategory =
        tbrInProgress.categories[selectedSection.toLowerCase()][0];
    filteredQuestions = tbrInProgress.getQuestions(
        sectionIn: selectedSection, categoryIn: selectedCategory);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // List<TextEditingController>.generate(3, (TextEditingController index) => index * index);
    return Column(
      children: [
        // Section DropDown
        Row(
          children: [
            TextButton(
                child: Text('fill out all Yes'),
                onPressed: () {
                  for (String key in tbrInProgress.answers.keys) {
                    tbrInProgress.answers[key] = [true, false, false];
                  }
                  setState(() {});
                }),
            TextButton(
                child: Text('fill out all No'),
                onPressed: () {
                  for (String key in tbrInProgress.answers.keys) {
                    tbrInProgress.answers[key] = [false, true, false];
                  }
                  setState(() {});
                }),
            TextButton(
                child: Text('fill out all N/A'),
                onPressed: () {
                  for (String key in tbrInProgress.answers.keys) {
                    tbrInProgress.answers[key] = [false, false, true];
                  }
                  setState(() {});
                }),
            TextButton(
                child: Text('fill out all Random'),
                onPressed: () {
                  for (String key in tbrInProgress.answers.keys) {
                    int randomNumber = Random().nextInt(3);
                    List<bool> temp = [false, false, false];
                    temp[randomNumber] = true;
                    tbrInProgress.answers[key] = temp;
                  }
                  setState(() {});
                }),
          ],
        ),
        DropdownButton(
          hint: Text(selectedSection),
          items: tbrInProgress.sections.map((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          // ignore: avoid_types_on_closure_parameters
          onChanged: (String value) {
            print(value);
            setState(() {
              selectedSection = value;
              selectedCategory =
                  tbrInProgress.categories[selectedSection.toLowerCase()][0];
              filteredQuestions = tbrInProgress.getQuestions(
                  sectionIn: selectedSection, categoryIn: selectedCategory);
            });
          },
        ),
        // Category DropDown
        DropdownButton(
          hint: Text(selectedCategory),
          items: tbrInProgress.categories[selectedSection.toLowerCase()]
              .map((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          // ignore: avoid_types_on_closure_parameters
          onChanged: (String value) {
            print(value);
            setState(() {
              selectedCategory = value;
              filteredQuestions = tbrInProgress.getQuestions(
                  sectionIn: selectedSection, categoryIn: selectedCategory);
            });
          },
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: false,
            // Let the ListView know how many items it needs to build.
            itemCount: filteredQuestions.length,
            // Provide a builder function. This is where the magic happens.
            // Convert each item into a widget based on the type of item it is.
            itemBuilder: (context, index) {
              final Question question = filteredQuestions[index];
              // print('tbrInProgress.colorScheme: ${tbrInProgress.colorScheme}');
              final Map<String, List<Color>> colorScheme =
                  tbrInProgress.colorScheme[question.id];

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
                            text: tbrInProgress.adminComment[question.id]),
                        onChanged: (value) {
                          tbrInProgress.adminComment[question.id] = value;
                        },
                        minLines: 2,
                        maxLines: 5,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          hintText: 'Put system administrator notes here...',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                        ),
                      ),
                      const Text('TAM Notes'),
                      TextField(
                        controller: TextEditingController(
                            text: tbrInProgress.tamNotes[question.id]),
                        onChanged: (value) {
                          tbrInProgress.tamNotes[question.id] = value;
                        },
                        minLines: 2,
                        maxLines: 5,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          hintText: 'Put TAM Notes here...',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
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
                          'Priority: ${filteredQuestions[index].questionPriority}',
                      child: Icon(
                        Icons.brightness_1,
                        color: buttonColor(filteredQuestions[index]
                            .questionPriority
                            .toLowerCase()),
                        size: 25,
                      ),
                    )
                  ]),
                ),
                title: Text(question.questionText),
                subtitle: Text(question.questionName),
                trailing: Container(
                  width: 200,
                  child: Row(
                    children: [
                      // TextButton(
                      //   child: Text('Yes'),
                      //   style: TextButton.styleFrom(
                      //     primary: Colors.white,
                      //     backgroundColor: Colors.teal,
                      //     onSurface: Colors.grey,
                      //   ),
                      //   onPressed: () {
                      //     print('Pressed');
                      //   },
                      // ),
                      // TextButton(
                      //   child: Text('No'),
                      //   style: TextButton.styleFrom(
                      //     primary: Colors.white,
                      //     backgroundColor: Colors.teal,
                      //     onSurface: Colors.grey,
                      //   ),
                      //   onPressed: () {
                      //     print('Pressed');
                      //   },
                      // ),
                      const Icon(Icons.edit),
                      CustomToggleButtons(
                        children: const [Text('Yes'), Text('No'), Text('N/A')],
                        isSelected: tbrInProgress.answers[question.id],
                        onPressed: (index) {
                          print(index);
                          final List<bool> presentValue =
                              tbrInProgress.answers[question.id];
                          final List<bool> tempValue = [false, false, false];
                          setState(() {
                            tempValue[index] = !presentValue[index];
                            tbrInProgress.answers[question.id] = tempValue;
                          });
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
        ),

        Row(
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
                            section: selectedSection,
                            category: selectedCategory);
                    setState(() {
                      selectedSection = newSectionCategory['section'];
                      selectedCategory = newSectionCategory['category'];
                      filteredQuestions = tbrInProgress.getQuestions(
                          sectionIn: selectedSection,
                          categoryIn: selectedCategory);
                    });
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
                            section: selectedSection,
                            category: selectedCategory);
                    setState(() {
                      selectedSection = newSectionCategory['section'];
                      selectedCategory = newSectionCategory['category'];
                      filteredQuestions = tbrInProgress.getQuestions(
                          sectionIn: selectedSection,
                          categoryIn: selectedCategory);
                    });
                  },
                ),
              ),
            )
          ],
        ),
      ],
    ); //
  }
}
