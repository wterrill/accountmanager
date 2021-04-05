import 'package:accountmanager/app/web_view_home/overview3/data_table.dart';
import 'package:accountmanager/models/company.dart';
import 'package:accountmanager/models/questionnaire_type.dart';
import 'package:accountmanager/models/technician.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

StateProvider<bool> showAllSwitchProvider =
    StateProvider<bool>((dynamic ref) => true);

class Overview3WebPage extends StatefulWidget {
  final bool mobile;

  const Overview3WebPage({Key key, @required this.mobile}) : super(key: key);

  @override
  _Overview3WebPageState createState() => _Overview3WebPageState();
}

class _Overview3WebPageState extends State<Overview3WebPage> {
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
    return Container(
      color: Colors.white,
      child: Column(children: const [
        CreateOverview3SelectDataTableWidget(mobile: false),
      ]),
    );
  }
}
