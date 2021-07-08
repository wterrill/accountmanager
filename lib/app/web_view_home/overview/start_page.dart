import 'package:accountmanager/app/web_view_home/assign_TBR/widget_assign_TBR_dialog.dart';
import 'package:accountmanager/app/web_view_home/overview/create_overview_select_data_table.dart';
import 'package:accountmanager/app/web_view_home/overview/filter_row.dart';
import 'package:accountmanager/common_utilities/buttonConverter.dart';
import 'package:accountmanager/common_widgets/display_widget_dialog_with_error.dart';
import 'package:accountmanager/constants/color_defs.dart';
import 'package:accountmanager/constants/strings.dart';
import 'package:accountmanager/constants/text_styles.dart';
import 'package:accountmanager/models/Status.dart';
import 'package:accountmanager/models/company.dart';
import 'package:accountmanager/models/questionnaire_type.dart';
import 'package:accountmanager/models/technician.dart';
import 'package:accountmanager/packages/alert_dialogs/alert_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

StateProvider<bool> showAllSwitchProvider =
    StateProvider<bool>((dynamic ref) => false);

StateProvider<String> companyFilterProvider =
    StateProvider<String>((dynamic ref) => '');

StateProvider<Status?> statusFilterProvider =
    StateProvider<Status?>((dynamic ref) => null);

StateProvider<String> technicianIDFilterProvider =
    StateProvider<String>((dynamic ref) => '');

class OverviewWebPage extends ConsumerWidget {
  OverviewWebPage({Key? key, this.mobile = false}) : super(key: key);
  final bool mobile;
  late final Technician? selectedTechnician;
  late final Company? selectedCompany;
  late final Status? selectedStatus;
  late final QuestionnaireType? selectedQuestionnaireType;
  late final DateTime? startdateTBR;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final String companyFilter = watch(companyFilterProvider).state;
    final String technicianIDFilter = watch(technicianIDFilterProvider).state;
    final Status? statusFilter = watch(statusFilterProvider).state;
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
                const Text('TBR Evaluations', style: StyleDefs.heading1),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 8.0, 18.0, 0.0),
                  child: InkWell(
                    child: FlatButtonX(
                        colorx: const Color(0xFF002244),
                        shapex: ShapeDefs.noColorRoundedBorder,
                        onPressedx: () {
                          displayWidgetDialogWithError(
                              context, '', const AssignTBR());
                        },
                        childx: const Text('Create Evaluation',
                            style: StyleDefs.button1White)),
                  ),
                )
              ],
            ),
          ),
          FilterRow(),
          CreateOverviewSelectDataTableWidget(
              mobile: false,
              filterCompanyText: companyFilter,
              technicianIDFilter: technicianIDFilter,
              statusFilter: statusFilter),
        ]),
      ),
    );
  }
}
