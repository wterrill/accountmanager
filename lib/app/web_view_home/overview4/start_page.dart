import 'package:accountmanager/app/web_view_home/overview4/data_table.dart';
import 'package:accountmanager/models/company.dart';
import 'package:accountmanager/models/questionnaire_type.dart';
import 'package:accountmanager/models/technician.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

StateProvider<bool> showAllSwitchProvider =
    StateProvider<bool>((dynamic ref) => true);

class Overview4WebPage extends StatefulWidget {
  final bool mobile;

  const Overview4WebPage({Key key, @required this.mobile}) : super(key: key);

  @override
  _Overview4WebPageState createState() => _Overview4WebPageState();
}

class _Overview4WebPageState extends State<Overview4WebPage> {
  Technician selectedTechnician;
  Company selectedCompany;
  QuestionnaireType selectedQuestionnaireType;
  DateTime startdateTBR;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          const Text('Show Completed'),
          Consumer(builder: (context, watch, child) {
            final bool switchState = watch(showAllSwitchProvider).state;
            print(switchState);

            return Switch(
              onChanged: (boo) {
                context.read(showAllSwitchProvider).state = boo;
              },
              value: context.read(showAllSwitchProvider).state,
              activeTrackColor: Colors.lightGreenAccent,
              activeColor: Colors.green,
            );
          }),
        ],
      ),
      CreateOverview4SelectDataTableWidget(mobile: widget.mobile),
    ]);
  }
}
