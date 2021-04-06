import 'package:accountmanager/constants/text_styles.dart';
import 'package:accountmanager/models/company.dart';
import 'package:accountmanager/common_widgets/list_items_builder.dart';
import 'package:accountmanager/packages/alert_dialogs/alert_dialogs.dart';
import 'package:accountmanager/app/web_view_home/create_company/company_list_tile.dart';
import 'package:accountmanager/app/web_view_home/create_company/input_company_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:accountmanager/app/top_level_providers.dart';
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
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('MXO Companies', style: TextStyles.heading1),
          const SizedBox(height: 30),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9.0),
              side: BorderSide(
                color: Colors.red.withOpacity(0.8),
                width: 1,
              ),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Add Company', style: TextStyles.heading2),
                  Container(
                      height: 200,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: InputCompany(),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Active Companies', style: TextStyles.heading2),
                  ),
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
                            trailing: TextButton(
                                child: const Text('delete'),
                                onPressed: () =>
                                    _deleteCompany(context, company)),
                            company: company,
                            onTap:
                                () {} // => JobEntriesPage.show(context, job),
                            ),
                        // onDismissed: (direction) =>
                        //     _deleteCompany(context, company),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
