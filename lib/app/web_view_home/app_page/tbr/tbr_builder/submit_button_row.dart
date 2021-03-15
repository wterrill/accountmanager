import 'package:accountmanager/models/tbr.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/common_widgets/display_widget_dialog_with_error.dart';
import 'package:accountmanager/packages/alert_dialogs/alert_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pedantic/pedantic.dart';

class SubmitButtonRow extends ConsumerWidget {
  const SubmitButtonRow({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    Future<void> sendCompletedEvaluation({TBRinProgress tbrInProgress}) async {
      try {
        final database = context.read(databaseProvider);
        await database.setEvaluation(tbrInProgress);
      } catch (e) {
        unawaited(showExceptionAlertDialog(
          context: context,
          title: 'Operation failed',
          exception: e,
        ));
        // }
      }
    }

    final TBRinProgress tbrInProgress = watch(tbrInProgressProvider).state;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (tbrInProgress.showSubmitButton)
            TextButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green)),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Submit'),
              ),
              onPressed: () {
                print('submitted');
                displayWidgetDialogWithError(
                  context,
                  'Submit Evaluation',
                  Container(
                    width: 200,
                    height: 300,
                    child: Column(
                      children: [
                        TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.green)),
                            child: const Text('Send'),
                            onPressed: () async {
                              // final AssignedTBR assignedTbr = createCurrentTBR(assignedBy);

                              await sendCompletedEvaluation(
                                  tbrInProgress: tbrInProgress);

                              Navigator.of(context).pop();
                            }),
                        const SizedBox(height: 50),
                        TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green)),
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                  ),
                );
                // showAlertDialog(
                //   context: context,
                //   title: 'Submit Evaluation',
                //   content: 'Are you sure you want to submit this evaluation?',
                //   cancelActionText: 'Cancel',
                //   defaultActionText: 'Yes',
                // );
              },
            )
        ],
      ),
    );
  }
}
