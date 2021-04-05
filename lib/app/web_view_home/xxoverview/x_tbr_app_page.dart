import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/app/web_view_home/app_page/tbr/tbr_builder/tbr_builder.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:accountmanager/models/assigned_tbr.dart';
import 'package:accountmanager/models/question.dart';
import 'package:accountmanager/common_widgets/empty_content.dart';

class TBRappPage extends StatelessWidget {
  const TBRappPage({
    Key key,
    this.assignedTBR,
  }) : super(key: key);
  final AssignedTBR assignedTBR;

  @override
  Widget build(BuildContext context) {
    return TBRdata();
  }
}

class TBRdata extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final questionAsyncValue = watch(questionStreamProvider);
    return TBRConverter(questionData: questionAsyncValue);
  }
}

class TBRConverter extends StatefulWidget {
  const TBRConverter({Key key, @required this.questionData}) : super(key: key);
  final AsyncValue<List<Question>> questionData;

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
    return widget.questionData.when(
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
