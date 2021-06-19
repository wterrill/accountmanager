import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/common_utilities/get_techs_from_ids.dart';
import 'package:accountmanager/models/technician.dart';
import 'package:accountmanager/services/firestore_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:accountmanager/models/assigned_tbr.dart';
import 'package:intl/intl.dart';

class SendEmailFinishedDialog extends StatelessWidget {
  const SendEmailFinishedDialog({
    Key? key,
    required this.assignedTbr,
  }) : super(key: key);
  final AssignedTBR assignedTbr;

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = context.read(firebaseAuthProvider);
    final User? user = firebaseAuth.currentUser!;
    final String emailText = '''
        <p>The user:</p> 
        <h2>${user?.email}</h2>
        <p>on the date: </p>
        <h2>${DateFormat.yMMMEd().format(DateTime.now())} </h2>
        <p>has completed and uploaded a </p>
        <h2>${assignedTbr.questionnaireType}</h2>
        <p>type report.</p> 
        <p>---------------------</p>
        <p>It was originally assigned by:</p>
        <h2>${assignedTbr.assignedBy}</h2> 
        <p> for the company: </p>
        <h2>${assignedTbr.company.name}</h2> 
        <p>with a due date of: </p>
        <h2>${DateFormat.yMMMEd().format(assignedTbr.dueDate!)} </h2>
        <p>and a client meeting date of:</p>
        <h2>${DateFormat.yMMMEd().format(assignedTbr.clientMeetingDate!)}</h2>''';
    final FirestoreDatabase? database = context.read(databaseProvider);
    database!.sendEmail(
        toList: [assignedTbr.assignedBy],
        from:
            "TODO", //getListEmailsFromIds(assignedTbr.technicianIds!, context),
        body: emailText,
        subject: 'TBR for ${assignedTbr.company.name} completed:');
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(getListEmailsFromIds(assignedTbr.technicianIds!, context)
            .toString()),
        Text('to: ${assignedTbr.assignedBy}'),
        const Text('Completion email sent')
      ],
    );
  }
}

List<String> getListEmailsFromIds(List<String> techIds, BuildContext context) {
  final List<Technician> returnedTechs = getTechsFromId(techIds, context);
  final List<String> emails = returnedTechs.map((tech) => tech.email).toList();
  return emails;
}
