import 'package:accountmanager/app/home/create_company/input_company_ui.dart';
import 'package:accountmanager/app/home/models/company.dart';
import 'package:accountmanager/packages/alert_dialogs/alert_dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:accountmanager/app/home/job_entries/job_entries_page.dart';
// import 'package:accountmanager/app/home/create_tech/edit_job_page.dartx';
import 'package:accountmanager/app/home/create_company/company_list_tile.dart';
import 'package:accountmanager/app/home/create_company/list_items_builder.dart';
// import 'package:accountmanager/app/home/models/job.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/constants/strings.dart';
import 'package:pedantic/pedantic.dart';
// import 'package:accountmanager/packages/alert_dialogs/alert_dialogs.dart';

final companyStreamProvider = StreamProvider.autoDispose<List<Company>>((ref) {
  final database = ref.watch(databaseProvider);
  return database?.companyStream() ?? const Stream.empty();
});

// watch database
class CreateCompanyPage extends ConsumerWidget {
  Future<void> _deleteCompany(BuildContext context, Company company) async {
    try {
      final database = context.read(databaseProvider);
      await database.deleteCompany(company);
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
    final companyAsyncValue = watch(companyStreamProvider);
    return Column(
      children: [
        Container(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const InputCompany(),
            )),
        Container(
          height: 300,
          child: ListItemsBuilder<Company>(
            data: companyAsyncValue,
            itemBuilder: (context, company) => Dismissible(
              key: Key('job-${company.id}'),
              background: Container(color: Colors.red),
              direction: DismissDirection.endToStart,
              // onDismissed: (direction) => _delete(context, job),
              child: CompanyListTile(
                  company: company,
                  onTap: () {} // => JobEntriesPage.show(context, job),
                  ),
              onDismissed: (direction) => _deleteCompany(context, company),
            ),
          ),
        ),
      ],
    );
  }
}
