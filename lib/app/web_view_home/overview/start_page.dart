import 'package:accountmanager/app/web_view_home/assign_TBR/widget_assign_TBR2.dart';
import 'package:accountmanager/app/web_view_home/overview/data_table.dart';
import 'package:accountmanager/common_utilities/buttonConverter.dart';
import 'package:accountmanager/common_widgets/display_widget_dialog_with_error.dart';
import 'package:accountmanager/constants/color_defs.dart';
import 'package:accountmanager/constants/strings.dart';
import 'package:accountmanager/constants/text_styles.dart';
import 'package:accountmanager/models/company.dart';
import 'package:accountmanager/models/questionnaire_type.dart';
import 'package:accountmanager/models/technician.dart';
import 'package:accountmanager/packages/alert_dialogs/alert_dialogs.dart';
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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(48.0, 48.0, 0.0, 48.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 28.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('TBR Evaluations', style: TextStyles.heading1),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 8.0, 18.0, 0.0),
                  child: InkWell(
                    child: FlatButtonX(
                        colorx: const Color(0xFF002244),
                        shapex: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        onPressedx: () {
                          displayWidgetDialogWithError(context,
                              Strings.tbrStrings.assignTbr, const AssignTBR());
                        },
                        childx: const Text('Create Evaluation',
                            style: TextStyles.button1White)),
                  ),
                )
              ],
            ),
          ),
          const CreateOverviewSelectDataTableWidget(mobile: false),
        ]),
      ),
    );
  }
}
