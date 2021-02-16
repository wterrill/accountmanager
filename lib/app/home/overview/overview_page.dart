import 'dart:async';

import 'package:accountmanager/app/home/overview/overview_datatableNOFUTURE.dart';
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

import '../models/tbr.dart';

class OverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TBRinProgress tbrInProgress = context.read(tbrInProgressProvider);
    if (tbrInProgress.allQuestions == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 1, child: Text('')),
              Expanded(
                flex: 1,
                child: Center(
                  child: FractionallySizedBox(
                    widthFactor: 0.4,
                    child: Text(
                      'In order to use the development overivew page (...um...this one), first go to the App page, and fill out a TBR questionnaire. (it doesn\'t have to be done in its entirety)\n\nThen, come back to this page to see the results.  This is only done for speed of development.  The final version will have the user select from a list of completed TBRs, that would then show the overview in its entirety for that specific TBR.',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(''),
                    ),
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/images/3dDownArrow.gif',
                        height: 125.0,
                        width: 125.0,
                      ),
                    ),
                    Expanded(flex: 2, child: Text('')),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        child: SingleChildScrollView(
          child: OverviewPaginatedTable(),
        ),
      );
    }
  }
}
