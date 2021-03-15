import 'package:accountmanager/web_view_home/overview/create_datatable_widget2.dart';
import 'package:flutter/material.dart';

class OverviewWebPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TBRinProgress tbrInProgress = context.read(tbrInProgressProvider).state;
    return Column(children: const [
      CreateOverviewSelectDataTableWidget(mobile: false),
    ]);
    // return Container(
    //   child: SingleChildScrollView(
    //     child: OverviewPaginatedTable(),
    //   ),
    // );
  }
}
