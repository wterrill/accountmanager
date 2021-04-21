import 'package:accountmanager/app/web_view_home/create_technician/technician_dialog.dart';
import 'package:accountmanager/constants/text_styles.dart';
import 'package:accountmanager/models/technician.dart';
import 'package:accountmanager/packages/alert_dialogs/alert_dialogs.dart';
import 'package:accountmanager/app/web_view_home/create_technician/technician_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:accountmanager/common_widgets/list_items_builder.dart';
import 'package:accountmanager/app/top_level_providers.dart';

final technicianStreamProvider =
    StreamProvider.autoDispose<List<Technician>>((ref) {
  final database = ref.watch(databaseProvider);
  return database?.technicianStream() ?? const Stream.empty();
});

// watch database
class CreateTechWebPage extends ConsumerWidget {
  // Future<void> _deleteTechnician(
  //     BuildContext context, Technician technician) async {
  //   try {
  //     final database = context.read(databaseProvider);
  //     await database.deleteTechnician(technician);
  //   } catch (e) {
  //     unawaited(showExceptionAlertDialog(
  //       context: context,
  //       title: 'Operation failed',
  //       exception: e,
  //     ));
  //   }
  // }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    print('build create_tech_page.dart');
    return _buildContents(context, watch);
  }

  Widget _buildContents(BuildContext context, ScopedReader watch) {
    final technicianAsyncValue = watch(technicianStreamProvider);
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('MXO Technicians', style: TextStyles.heading1),
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
                  // Text('Add Technician', style: TextStyles.heading2),
                  // Container(
                  //     height: 200,
                  //     child: const Padding(
                  //       padding: EdgeInsets.all(8.0),
                  //       child: InputTechnician(),
                  //     )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        Text('Active Technicians', style: TextStyles.heading2),
                  ),
                  Container(
                    height: 600,
                    child: ListItemsBuilder<Technician>(
                        data: technicianAsyncValue,
                        itemBuilder: (context, technician) {
                          return TechnicianListTile(
                              // trailing: TextButton(
                              //     child: const Text('delete'),
                              //     onPressed: () =>
                              //         _deleteTechnician(context, technician)),
                              technician: technician,
                              onTap: () {
                                showWidgetDialog(
                                    context: context,
                                    title: 'Technician information',
                                    widget: TechnicianDialog(
                                        technician: technician));
                              } // => JobEntriesPage.show(context, job),
                              );
                          // onDismissed: (direction) =>
                          //     _deleteTechnician(context, technician),
                        }),
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
