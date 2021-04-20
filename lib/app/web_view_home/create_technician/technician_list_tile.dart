import 'package:accountmanager/models/technician.dart';
import 'package:flutter/material.dart';

class TechnicianListTile extends StatelessWidget {
  const TechnicianListTile(
      {Key key, @required this.technician, this.onTap, this.trailing})
      : super(key: key);
  final Technician technician;
  final VoidCallback onTap;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${technician.firstName} ${technician.lastName}'),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
