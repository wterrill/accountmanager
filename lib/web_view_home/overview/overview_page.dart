import 'dart:async';

import 'package:accountmanager/app/home/models/tbr.dart';
import 'package:accountmanager/app/home/overview/overview_datatableNOFUTURE.dart';
import 'package:accountmanager/web_view_home/app_page/tbr_selection/create_datatable_widget2.dart';
import 'package:accountmanager/web_view_home/overview/create_datatable_widget2.dart';
// import 'package:accountmanager/app/home/overview/overview_datatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/common_widgets/avatar.dart';
import 'package:accountmanager/constants/keys.dart';
import 'package:accountmanager/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:accountmanager/packages/alert_dialogs/alert_dialogs.dart';

class OverviewWebPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TBRinProgress tbrInProgress = context.read(tbrInProgressProvider).state;
    return Column(children: [
      CreateOverviewSelectDataTableWidget(mobile: false),
    ]);
    // return Container(
    //   child: SingleChildScrollView(
    //     child: OverviewPaginatedTable(),
    //   ),
    // );
  }
}
