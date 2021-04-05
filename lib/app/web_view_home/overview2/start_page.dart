import 'package:accountmanager/app/web_view_home/overview2/data_table.dart';
import 'package:flutter/material.dart';

class Overview2WebPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TBRinProgress tbrInProgress = context.read(tbrInProgressProvider).state;
    return Container(
      color: Colors.white,
      child: Column(children: const [
        CreateOverview2SelectDataTableWidget(mobile: false),
      ]),
    );
  }
}
