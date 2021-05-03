import 'package:accountmanager/constants/strings.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:pedantic/pedantic.dart';

import 'package:accountmanager/packages/alert_dialogs/alert_dialogs.dart';

class ShowDialogButton extends StatelessWidget {
  const ShowDialogButton({
    Key? key,
    this.name,
  }) : super(key: key);
  final String? name;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
      // style: TextButton.styleFrom(backgroundColor: Colors.red),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Show Dialog'),
      ),

      onPressed: () {
        print('pressed');
        _displayDialog(context);
      },
    );
  }

  Future<void> _displayDialog(BuildContext context) async {
    if (_validateAndSaveForm()) {
      try {
        await showWidgetDialog(
          context: context,
          title: Strings.tbrStrings.assignTbr,
          widget: const Text('hello'),
          defaultActionText: 'Assign',
          cancelActionText: 'Cancel',
        );
      } catch (e) {
        unawaited(showExceptionAlertDialog(
          context: context,
          title: 'Operation failed',
          exception: e,
        ));
      }
    }
  }

  bool _validateAndSaveForm() {
    return true;
  }
}
