import 'package:accountmanager/app/home/models/tbr.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/common_widgets/custom_toggle_buttons.dart';
import 'package:accountmanager/web_view_home/app_page/tbr/tbr_builder/tbr_builder.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:accountmanager/app/home/models/assignedTbr.dart';
import 'package:accountmanager/app/home/models/question.dart';
import 'package:accountmanager/app/home/question/create_data_table.dart';
import 'package:accountmanager/common_widgets/empty_content.dart';

class TBRappPage extends StatelessWidget {
  const TBRappPage({
    Key key,
    this.data,
  }) : super(key: key);
  final AssignedTBR data;

  @override
  Widget build(BuildContext context) {
    return TBRdata();
  }
}

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
