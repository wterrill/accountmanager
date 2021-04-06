import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/constants/strings.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedantic/pedantic.dart';

import 'package:accountmanager/models/technician.dart';
import 'package:accountmanager/packages/alert_dialogs/alert_dialogs.dart';
import 'package:accountmanager/services/firestore_database.dart';

class InputTechnician extends StatefulWidget {
  const InputTechnician({
    Key key,
  }) : super(key: key);

  @override
  _InputTechnicianState createState() => _InputTechnicianState();
}

class _InputTechnicianState extends State<InputTechnician> {
  String name;
  TextEditingController textController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textController.addListener(() {
      final String text = textController.text;
      textController.value = textController.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: TextField(
            keyboardType: TextInputType.text,
            maxLength: 50,
            controller: textController,
            decoration: const InputDecoration(
              labelText: 'Employee First and Last Name',
              labelStyle:
                  TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
            keyboardAppearance: Brightness.light,
            style: const TextStyle(fontSize: 20.0, color: Colors.black),
            onChanged: (_) {
              name = textController.text;
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(),
        ),
        Expanded(
          flex: 1,
          child: TextButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    // side: BorderSide(
                    //   color: Colors.red.withOpacity(0.8),
                    //   width: 1,
                    // ),
                  ),
                ),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.green)),
            // style: TextButton.styleFrom(backgroundColor: Colors.red),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text('Add'),
            ),

            onPressed: () {
              textController.text = '';
              _submit(context, name);
            },
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(),
        ),
      ],
    );
  }
}

Future<void> _submit(BuildContext context, String name) async {
  if (_validateAndSaveForm(name)) {
    try {
      final database = context.read(databaseProvider);
      // final technicianNOTSURE = await database.technicianStream().first;

      final id = documentIdFromCurrentDate();
      final technician = Technician(id: id, name: name);
      await database.setTechnician(technician);
    } catch (e) {
      unawaited(showExceptionAlertDialog(
        context: context,
        title: 'Operation failed',
        exception: e,
      ));
    }
  }
}

bool _validateAndSaveForm(String name) {
  if (name != '') {
    return true;
  } else {
    return false;
  }
}
