import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/app/web_view_home/app_page/tbr_OLD/tbr_builder/send_email_finished_dialog.dart';
import 'package:accountmanager/common_utilities/get_techs_from_ids.dart';
import 'package:accountmanager/models/technician.dart';
import 'package:accountmanager/services/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:accountmanager/models/assigned_tbr.dart';
import 'package:intl/intl.dart';

class SendEmailAssignDialog extends StatelessWidget {
  const SendEmailAssignDialog({
    Key? key,
    required this.assignedTbr,
  }) : super(key: key);
  final AssignedTBR? assignedTbr;

  @override
  Widget build(BuildContext context) {
    final String emailText = '''
        <p>You have been assigned a TBR by:</p> 
        <h2>${assignedTbr!.assignedBy}</h2> 
        <p> for the company: </p>
        <h2>${assignedTbr!.company.name}</h2> 
        <p>with a due date of: </p>
        <h2>${DateFormat.yMMMEd().format(assignedTbr!.dueDate)} </h2>
        <p>and a client meeting date of:</p>
        <h2>${DateFormat.yMMMEd().format(assignedTbr!.clientMeetingDate)}</h2>''';
    final FirestoreDatabase? database = context.read(databaseProvider);
    database!.sendEmail(
        toList: getListEmailsFromIds(assignedTbr!.technicianIds, context),
        from: assignedTbr!.assignedBy,
        body: emailText,
        subject: 'new TBR assigned:');
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('from: ${assignedTbr!.assignedBy}'),
        Text(
            'to:${getListEmailsFromIds(assignedTbr!.technicianIds, context)} '),
        Text('time: ${DateTime.parse(assignedTbr!.id)}'),
        const Text('email sent')
      ],
    );
  }
}

List<String> getNameFromIds(List<String> techIds, BuildContext context) {
  final List<Technician> returnedTechs = getTechsFromId(techIds, context);
  final List<String> emails = returnedTechs.map((tech) => tech.email).toList();
  return emails;
}
