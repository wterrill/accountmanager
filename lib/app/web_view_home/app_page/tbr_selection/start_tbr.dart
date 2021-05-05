import 'package:accountmanager/app/web_view_home/app_page/tbr_selection/create_tbr_select_datatable_widget.dart';
import 'package:accountmanager/models/company.dart';
import 'package:accountmanager/models/questionnaire_type.dart';
import 'package:accountmanager/models/technician.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

StateProvider<bool> showAllSwitchProvider =
    StateProvider<bool>((dynamic ref) => true);

class SelectTBRPage extends StatefulWidget {
  final bool mobile;

  const SelectTBRPage({Key? key, required this.mobile}) : super(key: key);

  @override
  _SelectTBRPageState createState() => _SelectTBRPageState();
}

class _SelectTBRPageState extends State<SelectTBRPage> {
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
    return Column(children: [
      Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Show Completed'),
          ),
          Consumer(
              builder:
                  (BuildContext context, ScopedReader watch, Widget child) {
            final bool switchState = watch(showAllSwitchProvider) as bool;
            print(switchState);

            return Switch(
              onChanged: (boo) {
                context.read(showAllSwitchProvider).state = boo;
              },
              value: context.read(showAllSwitchProvider).state,
              activeTrackColor: Colors.lightGreenAccent,
              activeColor: Colors.green,
            );
          } as Widget Function(BuildContext,
                      T Function<T>(ProviderBase<Object?, T>), Widget?)),
        ],
      ),
      CreateAppSelectDataTableWidget(mobile: widget.mobile),
    ]);
  }
}
