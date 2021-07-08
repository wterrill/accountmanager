import 'package:accountmanager/app/web_view_home/app_page/tbr_OLD/tbr_builder/test_buttons.dart';
import 'package:accountmanager/app/web_view_home/overview/tbr_builder/send_email_finished_dialog.dart';
import 'package:accountmanager/models/Status.dart';
import 'package:accountmanager/models/assigned_tbr.dart';
import 'package:accountmanager/models/tbr_in_progress.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/common_widgets/display_widget_dialog_with_error.dart';
import 'package:accountmanager/packages/alert_dialogs/alert_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pedantic/pedantic.dart';

class SaveButtonRow extends ConsumerWidget {
  const SaveButtonRow({Key? key}) : super(key: key);
  // final Box<TBRinProgress> boxTBRinProgress;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    TBRinProgress tbrInProgress = watch(tbrInProgressProvider).state!;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.green)),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Save Progress'),
            ),
            onPressed: () {
              // boxTBRinProgress.put(tbrInProgress.id, tbrInProgress);

              // print('submitted');
              // displayWidgetDialogWithError(
              //   context,
              //   'Saved',
              //   Container(
              //     width: 200,
              //     height: 300,
              //     child: Column(
              //       children: [
              //         TextButton(
              //             style: ButtonStyle(
              //                 backgroundColor: MaterialStateProperty.all<Color>(
              //                     Colors.green)),
              //             child: const Text('Save'),
              //             onPressed: () async {}),
              //         const SizedBox(height: 50),
              //         TextButton(
              //           style: ButtonStyle(
              //               backgroundColor:
              //                   MaterialStateProperty.all<Color>(Colors.green)),
              //           child: const Text('Restore'),
              //           onPressed: () {},
              //         )
              //       ],
              //     ),
              //   ),
              // );
            },
          ),
          TextButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.green)),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Restore Progress'),
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
