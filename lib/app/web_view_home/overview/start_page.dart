import 'package:accountmanager/app/web_view_home/overview/data_table.dart';
import 'package:accountmanager/models/company.dart';
import 'package:accountmanager/models/questionnaire_type.dart';
import 'package:accountmanager/models/technician.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

StateProvider<bool> showAllSwitchProvider =
    StateProvider<bool>((dynamic ref) => false);

class OverviewWebPage extends StatefulWidget {
  final bool mobile;

  const OverviewWebPage({Key? key, required this.mobile}) : super(key: key);

  @override
  _OverviewWebPageState createState() => _OverviewWebPageState();
}

class _OverviewWebPageState extends State<OverviewWebPage> {
  Technician? selectedTechnician;
  Company? selectedCompany;
  QuestionnaireType? selectedQuestionnaireType;
  DateTime? startdateTBR;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(children: const [
        CreateOverviewSelectDataTableWidget(mobile: false),
      ]),
    );
  }
}
