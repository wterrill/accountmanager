import 'package:accountmanager/packages/alert_dialogs/alert_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';

Future<void> displayWidgetDialogWithError(
    BuildContext context, String title, Widget widget) async {
  try {
    final Map<String, dynamic> result = await showWidgetDialog(
      context: context,
      title: title,
      widget: widget,
      defaultActionText: '',
      cancelActionText: '',
    );
    print(result);
  } catch (e) {
    unawaited(showExceptionAlertDialog(
      context: context,
      title: 'Operation failed',
      exception: e,
    ));
  }
}
