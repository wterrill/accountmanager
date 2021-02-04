import 'package:accountmanager/app/home/models/TBR.dart';
import 'package:accountmanager/app/home/models/question.dart';
import 'package:accountmanager/app/home/question/create_data_table.dart';
import 'package:accountmanager/common_widgets/empty_content.dart';
import 'package:flutter/material.dart';

import 'package:accountmanager/app/home/assign_TBR/widget_assign_TBR2.dart';
import 'package:accountmanager/app/home/models/assignedTbr.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
  @override
  void initState() {
    tbrInProgress = TBRinProgress(allQuestions: widget.questionList);
    selectedSection = tbrInProgress.sections[1];
    selectedCategory = tbrInProgress.categories[selectedSection][0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('category: ${tbrInProgress.categories}'),
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
            });
          },
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
            });
          },
        ),
        DropdownButton(
          hint: Text(selectedCategory),
          items: tbrInProgress.categories[selectedSection].map((value) {
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
            });
          },
        ),
      ],
    ); //
  }
}
