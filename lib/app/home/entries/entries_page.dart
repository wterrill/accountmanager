import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:accountmanager/app/home/entries/entries_view_model.dart';
import 'package:accountmanager/app/home/entries/entries_list_tile.dart';
import 'package:accountmanager/app/home/jobs/list_items_builder.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/constants/strings.dart';

final entriesTileModelStreamProvider =
    StreamProvider.autoDispose<List<EntriesListTileModel>>(
  (ref) {
    final database = ref.watch(databaseProvider);
    if (database != null) {
      final vm = EntriesViewModel(database: database);
      return vm.entriesTileModelStream;
    }
    return const Stream.empty();
  },
);

class EntriesPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.entries),
        elevation: 2.0,
      ),
      body: _buildContents(context, watch),
    );
  }

  Widget _buildContents(BuildContext context, ScopedReader watch) {
    final entriesTileModelStream = watch(entriesTileModelStreamProvider);
    return ListItemsBuilder<EntriesListTileModel>(
      data: entriesTileModelStream,
      itemBuilder: (context, model) => EntriesListTile(model: model),
    );
  }
}
