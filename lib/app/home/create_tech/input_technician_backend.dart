import 'dart:async';
import 'package:accountmanager/app/home/models/technician.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/services/firestore_database.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:accountmanager/app/home/job_entries/entry_list_item.dart';
// import 'package:accountmanager/app/home/job_entries/entry_page.dart';
// import 'package:accountmanager/app/home/jobs/edit_job_page.dart';
// import 'package:accountmanager/app/home/jobs/list_items_builder.dart';
// import 'package:accountmanager/app/home/models/entry.dart';
// import 'package:accountmanager/app/home/models/job.dart';
import 'package:accountmanager/packages/alert_dialogs/alert_dialogs.dart';
// import 'package:accountmanager/routing/cupertino_tab_view_router.dart';
import 'package:pedantic/pedantic.dart';

class UploadButton extends StatelessWidget {
  const UploadButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: const Text('upload to database'),
      color: Colors.green,
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
        final technician = Technician(id: id, name: _name());
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

  String _name() {
    return 'Paul';
  }
}
