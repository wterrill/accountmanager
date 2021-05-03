import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/app/web_view_home/app_page/tbr/tbr_builder/tbr_builder.dart';
import 'package:accountmanager/common_widgets/empty_content.dart';

class TBRappPage extends ConsumerWidget {
  const TBRappPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final questionAsyncValue = watch(questionStreamProvider!);
    return questionAsyncValue.when(
      data: (items) => items.isNotEmpty
          ? TBRbuilder(questionList: items)
          : const EmptyContent(),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const EmptyContent(
        title: 'Something went wrong',
        message: 'Can\'t load items right now',
      ),
    );
  }
}
