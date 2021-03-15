import 'package:accountmanager/app/models/technician.dart';
import 'package:flutter/material.dart';

class TechnicianListTile extends StatelessWidget {
  const TechnicianListTile({Key key, @required this.technician, this.onTap})
      : super(key: key);
  final Technician technician;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(technician.name),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
