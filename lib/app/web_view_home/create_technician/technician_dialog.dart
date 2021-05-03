import 'package:accountmanager/models/technician.dart';
import 'package:flutter/material.dart';

class TechnicianDialog extends StatelessWidget {
  const TechnicianDialog({Key? key, this.technician}) : super(key: key);
  final Technician? technician;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('First Name: ${technician!.firstName}'),
        Text('LastName: ${technician!.lastName}'),
        Text('Email: ${technician!.email}'),
        Text('System ID: ${technician!.id}')
      ],
    );
  }
}
