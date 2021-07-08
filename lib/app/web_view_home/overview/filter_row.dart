import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/app/web_view_home/assign_TBR/future_dropdown.dart';
import 'package:accountmanager/app/web_view_home/overview/start_page.dart';
import 'package:accountmanager/common_utilities/buttonConverter.dart';
import 'package:accountmanager/constants/text_styles.dart';
import 'package:accountmanager/models/Status.dart';
import 'package:accountmanager/models/technician.dart';
import 'package:accountmanager/services/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FilterRow extends HookWidget {
  FilterRow({Key? key}) : super(key: key);
  Technician? selectedTechnician;
  Status? selectedStatus;

  @override
  Widget build(BuildContext context) {
    final FirestoreDatabase? database = context.read(databaseProvider);
    final focusNode = useFocusNode();
    final controller = useTextEditingController();
    selectedStatus = context.read(statusFilterProvider).state;
    return Row(
      children: [
        DropdownButton<Status>(
          value: selectedStatus,
          icon: const Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (newValue) {
            final Status temp = newValue as Status;
            selectedStatus = temp;
            context.read(statusFilterProvider).state = temp;
          },
          items: <Status>[Status(statusIndex: 0), Status(statusIndex: 2)]
              .map<DropdownMenuItem<Status>>((value) {
            return DropdownMenuItem<Status>(
              value: value,
              child: Text(value.getStatusName()),
            );
          }).toList(),
        ),
        SizedBox(
          width: 100,
          child: TextField(
            decoration: const InputDecoration(
                border:
                    UnderlineInputBorder(borderSide: BorderSide(width: 2.0)),
                hintText: 'Company'),
            controller: controller,
            style: const TextStyle(color: ColorDefs.black),
            onChanged: (text) {
              context.read(companyFilterProvider).state = text;
            },
          ),
        ),
        FutureDropdown(
          hint: 'Technician:',
          selectedData: selectedTechnician,
          future: database!.technicianStream().first,
          onSelected: () {
            print('selected');
          },
          onSelectedChange: (technician) {
            final Technician temp = technician as Technician;
            context.read(technicianIDFilterProvider).state = temp.id;
          },
        ),
        InkWell(
          child: FlatButtonX(
              colorx: const Color(0xFF002244),
              shapex: ShapeDefs.noColorRoundedBorder,
              onPressedx: () {
                context.read(technicianIDFilterProvider).state = '';
                context.read(companyFilterProvider).state = '';
                context.read(statusFilterProvider).state = null;
                selectedTechnician = null;
              },
              childx:
                  const Text('Clear Filters', style: StyleDefs.button1White)),
        ),
      ],
    );
  }
}
