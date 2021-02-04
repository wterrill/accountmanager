import 'package:flutter/material.dart';

import 'package:accountmanager/app/home/assign_TBR/widget_assign_TBR2.dart';
import 'package:accountmanager/app/home/models/assignedTbr.dart';

class TBREntry extends StatelessWidget {
  const TBREntry({
    Key key,
    this.data,
  }) : super(key: key);
  final AssignedTBR data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('beer'),
    );
  }
}
