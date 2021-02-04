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

class TBRbuilder extends StatelessWidget {
  const TBRbuilder({Key key, this.questionList}) : super(key: key);
  final List<Question> questionList;

  @override
  Widget build(BuildContext context) {
    tbrInProgress = TBRinProgress(allQuestions: questionList);
    return Text('category: ${questionList[0].category}'); //
  }
}
