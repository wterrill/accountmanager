import 'package:accountmanager/models/technician.dart';
import 'package:accountmanager/packages/alert_dialogs/alert_dialogs.dart';
import 'package:accountmanager/app/web_view_home/create_technician/input_technician_ui.dart';
import 'package:accountmanager/app/web_view_home/create_technician/technician_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:accountmanager/common_widgets/list_items_builder.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:pedantic/pedantic.dart';

final technicianStreamProvider =
    StreamProvider.autoDispose<List<Technician>>((ref) {
  final database = ref.watch(databaseProvider);
  return database?.technicianStream() ?? const Stream.empty();
});

// watch database
class CreateTechWebPage extends ConsumerWidget {
  Future<void> _deleteTechnician(
      BuildContext context, Technician technician) async {
    try {
      final database = context.read(databaseProvider);
      await database.deleteTechnician(technician);
    } catch (e) {
      unawaited(showExceptionAlertDialog(
        context: context,
        title: 'Operation failed',
        exception: e,
      ));
    }
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    print('build create_tech_page.dart');
    return _buildContents(context, watch);
  }

  Widget _buildContents(BuildContext context, ScopedReader watch) {
    final technicianAsyncValue = watch(technicianStreamProvider);
    return Column(
      children: [
        Container(
            height: 200,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: InputTechnician(),
            )),
        Container(
          height: 300,
          child: ListItemsBuilder<Technician>(
            data: technicianAsyncValue,
            itemBuilder: (context, technician) => Dismissible(
              key: Key('job-${technician.id}'),
              background: Container(color: Colors.red),
              direction: DismissDirection.endToStart,
              // onDismissed: (direction) => _delete(context, job),
              child: TechnicianListTile(
                  technician: technician,
                  onTap: () {} // => JobEntriesPage.show(context, job),
                  ),
              onDismissed: (direction) =>
                  _deleteTechnician(context, technician),
            ),
          ),
        ),
      ],
    );
  }
}
