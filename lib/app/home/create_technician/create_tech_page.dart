import 'package:accountmanager/app/home/create_technician/input_technician_ui.dart';
import 'package:accountmanager/app/home/models/technician.dart';
import 'package:accountmanager/packages/alert_dialogs/alert_dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:accountmanager/app/home/job_entries/job_entries_page.dart';
// import 'package:accountmanager/app/home/create_tech/edit_job_page.dartx';
import 'package:accountmanager/app/home/create_technician/technician_list_tile.dart';
import 'package:accountmanager/app/home/create_technician/list_items_builder.dart';
// import 'package:accountmanager/app/home/models/job.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/constants/strings.dart';
import 'package:pedantic/pedantic.dart';
// import 'package:accountmanager/packages/alert_dialogs/alert_dialogs.dart';

// final jobsStreamProvider = StreamProvider.autoDispose<List<Job>>((ref) {
//   final database = ref.watch(databaseProvider);
//   return database?.jobsStream() ?? const Stream.empty();
// });

final technicianStreamProvider =
    StreamProvider.autoDispose<List<Technician>>((ref) {
  final database = ref.watch(databaseProvider);
  return database?.technicianStream() ?? const Stream.empty();
});

// watch database
class CreateTechPage extends ConsumerWidget {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.createTech),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: () {} //=> EditJobPage.show(context),
              ),
        ],
      ),
      body: _buildContents(context, watch),
    );
  }

  Widget _buildContents(BuildContext context, ScopedReader watch) {
    final technicianAsyncValue = watch(technicianStreamProvider);
    return Column(
      children: [
        Container(height: 300, child: const InputTechnician()),
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
