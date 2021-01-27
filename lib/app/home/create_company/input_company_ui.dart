import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/constants/strings.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedantic/pedantic.dart';

import 'package:accountmanager/app/home/models/company.dart';
import 'package:accountmanager/packages/alert_dialogs/alert_dialogs.dart';
import 'package:accountmanager/services/firestore_database.dart';

class InputCompany extends StatefulWidget {
  const InputCompany({
    Key key,
  }) : super(key: key);

  @override
  _InputCompanyState createState() => _InputCompanyState();
}

String _name;

class _InputCompanyState extends State<InputCompany> {
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(Strings.companyStrings.addCompany),
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
        final id = documentIdFromCurrentDate();
        final company = Company(id: id, name: _name);
        await database.setCompany(company);
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
