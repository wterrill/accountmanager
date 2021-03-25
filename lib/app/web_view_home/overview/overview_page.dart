import 'package:accountmanager/app/web_view_home/overview/create_overview_select_datatable_widget.dart';
import 'package:accountmanager/app/web_view_home/overview/excel_button.dart';
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
