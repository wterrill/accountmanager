import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:super_tooltip/super_tooltip.dart';

import 'package:accountmanager/app/home/assign_TBR/widget_assign_TBR2.dart';
import 'package:accountmanager/app/home/models/TBR.dart';
import 'package:accountmanager/app/home/models/assignedTbr.dart';
import 'package:accountmanager/app/home/models/question.dart';
import 'package:accountmanager/app/home/question/create_data_table.dart';
import 'package:accountmanager/common_widgets/empty_content.dart';

class TBREntry extends StatelessWidget {
  const TBREntry({
    Key key,
    this.data,
  }) : super(key: key);
  final AssignedTBR data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TBRdata(),
    );
  }
}

TBRinProgress tbrInProgress;

class TBRdata extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final questionAsyncValue = watch(questionStreamProvider); //**//**//**//**/
    return TBRConverter(data: questionAsyncValue);
  }
}

class TBRConverter extends StatefulWidget {
  const TBRConverter({Key key, @required this.data}) : super(key: key);
  final AsyncValue<List<Question>> data;

  @override
  _TBRConverterBuilderState createState() => _TBRConverterBuilderState();
}

class _TBRConverterBuilderState extends State<TBRConverter> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.data.when(
      data: (items) => items.isNotEmpty
          ? TBRbuilder(questionList: items) //_datatable(DTS(items, context))
          : const EmptyContent(),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const EmptyContent(
        title: 'Something went wrong',
        message: 'Can\'t load items right now',
      ),
    );
  }
}

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
  @override
  void initState() {
    tbrInProgress = TBRinProgress(allQuestions: widget.questionList);
    selectedSection = tbrInProgress.sections[1];
    selectedCategory =
        tbrInProgress.categories[selectedSection.toLowerCase()][0];
    filteredQuestions = tbrInProgress.getQuestions(
        sectionIn: selectedSection, categoryIn: selectedCategory);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
            // Let the ListView know how many items it needs to build.
            itemCount: filteredQuestions.length,
            // Provide a builder function. This is where the magic happens.
            // Convert each item into a widget based on the type of item it is.
            itemBuilder: (context, index) {
              final Question question = filteredQuestions[index];
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

              return ListTile(
                leading: Container(
                  width: 100,
                  child: Row(children: [
                    // const Icon(Icons.help_outline),
                    SuperToolTipWidget(
                      howString: question.howTo,
                      whyString: question.benefitsBusinessValue,
                    ),
                    Icon(
                      Icons.brightness_1,
                      color: buttonColor(filteredQuestions[index]
                          .questionPriority
                          .toLowerCase()),
                      size: 25,
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
                      ToggleButtons(
                        children: const [Text('Yes'), Text('No'), Text('N/A')],
                        isSelected: const [false, false, false],
                        onPressed: (index) {
                          print(index);
                        },
                        borderRadius: BorderRadius.circular(30),
                        borderWidth: 2,
                        borderColor: Colors.deepPurple,
                        selectedBorderColor: Colors.deepOrange,
                        splashColor: Colors.blue,
                        highlightColor: Colors.yellow,
                        color: Colors.red,
                        selectedColor: Colors.orange,
                        fillColor: Colors.amber,
                        renderBorder: true,
                        disabledColor: Colors.grey,
                        disabledBorderColor: Colors.grey,
                        hoverColor: Colors.pink,
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
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                print('pressed back');
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                print('pressed forward');
              },
            )
          ],
        ),
        Container(
          height: 150,
        )
      ],
    ); //
  }
}

class SuperToolTipWidget extends StatefulWidget {
  const SuperToolTipWidget({
    Key key,
    @required this.howString,
    @required this.whyString,
  }) : super(key: key);
  final String howString;
  final String whyString;

  @override
  _SuperToolTipWidgetState createState() => _SuperToolTipWidgetState();
}

class _SuperToolTipWidgetState extends State<SuperToolTipWidget> {
  SuperTooltip tooltip;

  Future<bool> _willPopCallback() async {
    // If the tooltip is open we don't pop the page on a backbutton press
    // but close the ToolTip
    if (tooltip.isOpen) {
      tooltip.close();
      return false;
    }
    return true;
  }

  void onTap() {
    if (tooltip != null && tooltip.isOpen) {
      tooltip.close();
      return;
    }

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    final Offset targetGlobalCenter = renderBox
        .localToGlobal(renderBox.size.center(Offset.zero), ancestor: overlay);

    // We create the tooltip on the first use
    tooltip = SuperTooltip(
      popupDirection: TooltipDirection.right,
      maxWidth: 600.0,
      showCloseButton: ShowCloseButton.inside,
      closeButtonColor: Colors.red,
      content: Material(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Why:', style: TextStyle(color: Colors.blue)),
                Text(
                  widget.whyString,
                  softWrap: true,
                ),
                const Text(''),
                const Text('How:', style: TextStyle(color: Colors.blue)),
                Text(
                  widget.howString,
                  softWrap: true,
                ),
              ]),
        ),
      ),
    );

    tooltip.show(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: GestureDetector(onTap: onTap, child: const Icon(Icons.help_outline)
          // Container(
          //     width: 20.0,
          //     height: 20.0,
          //     decoration: const BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: Colors.blue,
          //     )),
          ),
    );
  }
}
