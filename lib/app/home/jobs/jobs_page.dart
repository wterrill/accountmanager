import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:accountmanager/app/home/job_entries/job_entries_page.dart';
import 'package:accountmanager/app/home/jobs/edit_job_page.dart';
import 'package:accountmanager/app/home/jobs/job_list_tile.dart';
import 'package:accountmanager/app/home/jobs/list_items_builder.dart';
import 'package:accountmanager/app/home/models/job.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/constants/strings.dart';
import 'package:pedantic/pedantic.dart';
import 'package:accountmanager/packages/alert_dialogs/alert_dialogs.dart';

final jobsStreamProvider = StreamProvider.autoDispose<List<Job>>((ref) {
  final database = ref.watch(databaseProvider);
  return database?.jobsStream() ?? const Stream.empty();
});

// watch database
class JobsPage extends ConsumerWidget {
  Future<void> _delete(BuildContext context, Job job) async {
    try {
      final database = context.read(databaseProvider);
      await database.deleteJob(job);
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
    print('build jobs_page.dart');
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.jobs),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () => EditJobPage.show(context),
          ),
        ],
      ),
      body: _buildContents(context, watch),
    );
  }

  Widget _buildContents(BuildContext context, ScopedReader watch) {
    final jobsAsyncValue = watch(jobsStreamProvider);
    return ListItemsBuilder<Job>(
      data: jobsAsyncValue,
      itemBuilder: (context, job) => Dismissible(
        key: Key('job-${job.id}'),
        background: Container(color: Colors.red),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) => _delete(context, job),
        child: JobListTile(
          job: job,
          onTap: () => JobEntriesPage.show(context, job),
        ),
      ),
    );
  }
}
