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
    return Column(
      children: [
        TextField(
          keyboardType: TextInputType.text,
          maxLength: 50,
          controller: textController,
          decoration: const InputDecoration(
            labelText: 'Name',
            labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
          ),
          keyboardAppearance: Brightness.light,
          style: const TextStyle(fontSize: 20.0, color: Colors.black),
          onChanged: (_) {
            name = textController.text;
          },
        ),
        TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
          // style: TextButton.styleFrom(backgroundColor: Colors.red),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(Strings.technicianStrings.createTech),
          ),

          onPressed: () {
            textController.text = '';
            _submit(context, name);
          },
        )
      ],
    );
  }
}

Future<void> _submit(BuildContext context, String name) async {
  if (_validateAndSaveForm()) {
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

bool _validateAndSaveForm() {
  return true;
}
