import 'package:accountmanager/app/web_view_home/assign_TBR/widget_assign_TBR_dialog.dart';
import 'package:accountmanager/models/technician.dart';
import 'package:accountmanager/services/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// typedef RadioButtonCallback = void Function(Technician);
typedef RadioButtonCallback = void Function(List<String>);

class SelectListWithAll extends ConsumerWidget {
  SelectListWithAll({Key? key, required this.database, required this.callback})
      : super(key: key);
  final FirestoreDatabase database;
  final RadioButtonCallback callback;
  List<bool> selectStateList = List.filled(20, false);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return FutureBuilder(
        future: database.technicianStream().first,
        builder: (context, snapshot) {
          Color getColor(Set<MaterialState> states) {
            const Set<MaterialState> interactiveStates = <MaterialState>{
              MaterialState.pressed,
              MaterialState.hovered,
              MaterialState.focused,
            };
            if (states.any(interactiveStates.contains)) {
              return Colors.blue;
            }
            return Colors.red;
          }

          if (snapshot.hasData) {
            List<Technician> technicians = snapshot.data as List<Technician>;

            List<Widget> widgetTechList = [];
            for (var i = 0; i < technicians.length; i++) {
              String avatar_filename;
              if (technicians[i].filename == null ||
                  technicians[i].filename == 'Error') {
                avatar_filename = 'avatar_000.svg';
              } else {
                avatar_filename = technicians[i].filename!;
              }

              widgetTechList.add(Container(
                width: 300,
                child: CheckboxListTile(
                  title: Text('${technicians[i]}'),
                  secondary: SizedBox(
                      width: 40,
                      height: 40,
                      child: SvgPicture.asset(
                          'assets/avatars/${avatar_filename}')),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: selectStateList[i],
                  onChanged: (value) {
                    if (selectStateList.length == 20) {
                      selectStateList = List.filled(technicians.length, false);
                    }
                    selectStateList[i] = value!;
                    watch(selectListValueProvider).state = selectStateList;
                    final List<String> selectedTechnicianIDsResult = [];
                    for (i = 0; i < selectStateList.length; i++) {
                      if (selectStateList[i]) {
                        selectedTechnicianIDsResult.add(technicians[i].id);
                      }
                    }
                    callback(selectedTechnicianIDsResult);
                  },
                  // activeColor: MaterialStateProperty.resolveWith(getColor),
                ),
              ));
            }

            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 300,
                    child: CheckboxListTile(
                      title: const Text('All'),
                      controlAffinity: ListTileControlAffinity.leading,
                      value: watch(allStateProvider).state,
                      onChanged: (value) {
                        watch(allStateProvider).state = value!;
                        final List<bool> filledList = List.filled(20, !value);
                        // selectStateList = watch(selectListValueProvider).state;
                        // if (selectStateList.length != technicians.length ||
                        //     value == false) {
                        selectStateList =
                            List.filled(technicians.length, value);
                        // }

                        watch(selectListValueProvider).state = selectStateList;
                        print(watch(selectListValueProvider).state);
                        final List<String> selectedTechnicianIDsResult = [];
                        for (var i = 0; i < selectStateList.length; i++) {
                          if (selectStateList[i]) {
                            selectedTechnicianIDsResult.add(technicians[i].id);
                          }
                        }
                        callback(selectedTechnicianIDsResult);
                      },
                    ),
                  ),
                  Wrap(
                    children: [...widgetTechList],
                  )
                ]);
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
