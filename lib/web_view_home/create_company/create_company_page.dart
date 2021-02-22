import 'package:accountmanager/app/home/create_company/input_company_ui.dart';
import 'package:accountmanager/app/home/create_company/show_dialog_button.dart';
import 'package:accountmanager/app/home/models/company.dart';
import 'package:accountmanager/common_widgets/list_items_builder.dart';
import 'package:accountmanager/packages/alert_dialogs/alert_dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:accountmanager/app/home/create_company/company_list_tile.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/constants/strings.dart';
import 'package:pedantic/pedantic.dart';

final companyStreamProvider = StreamProvider.autoDispose<List<Company>>((ref) {
  final database = ref.watch(databaseProvider);
  return database?.companyStream() ?? const Stream.empty();
});

// watch database
class CreateCompanyWebPage extends ConsumerWidget {
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
    print('build create_company_page.dart');
    return _buildContents(context, watch);
  }

  Widget _buildContents(BuildContext context, ScopedReader watch) {
    final companyAsyncValue = watch(companyStreamProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Container(
        //   height: 200,
        //   child: const ShowDialogButton(),
        // ),
        Container(
            height: 200,
            width: 500,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: InputCompany(),
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
