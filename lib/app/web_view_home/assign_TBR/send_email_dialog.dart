import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/services/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:accountmanager/models/assigned_tbr.dart';

class SendEmailDialog extends StatelessWidget {
  const SendEmailDialog({
    Key key,
    @required this.assignedTbr,
  }) : super(key: key);
  final AssignedTBR assignedTbr;

  @override
  Widget build(BuildContext context) {
    final String emailText =
        'You have been assigned a TBR by: \n\n${assignedTbr.assignedBy} \n\nfor the company: \n\n${assignedTbr.company.name} \n\nwith a due date of: \n\n${assignedTbr.dueDate} \nand a client meeting date of:\n\n${assignedTbr.clientMeetingDate}';
    final FirestoreDatabase database = context.read(databaseProvider);
    database.sendEmail(
        toList: [assignedTbr.technician.email],
        from: assignedTbr.assignedBy,
        body: emailText,
        subject: 'new TBR assigned:');
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('from: ${assignedTbr.assignedBy}'),
        Text('to: ${assignedTbr.technician.email}'),
        Text('time: ${DateTime.parse(assignedTbr.id)}'),
        Text(emailText)
      ],
    );
  }
}
