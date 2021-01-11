import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/constants/strings.dart';
import 'package:flutter/material.dart';

import 'input_technician_backend.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedantic/pedantic.dart';

import 'package:accountmanager/app/home/models/technician.dart';
import 'package:accountmanager/packages/alert_dialogs/alert_dialogs.dart';
import 'package:accountmanager/services/firestore_database.dart';

class InputTechnician extends StatefulWidget {
  const InputTechnician({
    Key key,
  }) : super(key: key);

  @override
  _InputTechnicianState createState() => _InputTechnicianState();
}

String _name;

class _InputTechnicianState extends State<InputTechnician> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          keyboardType: TextInputType.text,
          maxLength: 50,
          controller: TextEditingController(text: _name),
          decoration: const InputDecoration(
            labelText: 'Name',
            labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
          ),
          keyboardAppearance: Brightness.light,
          style: const TextStyle(fontSize: 20.0, color: Colors.black),
          maxLines: null,
          onChanged: (name) => _name = name,
        ),
        const UploadButton(),
      ],
    );
  }
}

class UploadButton extends StatelessWidget {
  const UploadButton({
    Key key,
    this.name,
  }) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
      // style: TextButton.styleFrom(backgroundColor: Colors.red),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(Strings.createTech),
      ),

      onPressed: () {
        print('pressed');
        _submit(context);
      },
    );
  }

  Future<void> _submit(BuildContext context) async {
    if (_validateAndSaveForm()) {
      try {
        final database = context.read(databaseProvider);
        final technicianNOTSURE = await database.technicianStream().first;

        final id = documentIdFromCurrentDate();
        final technician = Technician(id: id, name: _name);
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

  // String _name() {
  //   return name;
  // }
}
