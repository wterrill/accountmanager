import 'package:accountmanager/models/technician.dart';
import 'package:accountmanager/services/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final selectListValueProvider =
    StateProvider<List<bool>>((ref) => List.filled(100, false));

final allStateProvider = StateProvider<bool>((ref) => false);

typedef RadioButtonCallback = void Function(Technician);

class SelectListWithAll extends ConsumerWidget {
  SelectListWithAll({Key? key, required this.database, required this.callback})
      : super(key: key);
  final FirestoreDatabase database;
  final RadioButtonCallback callback;
  List<bool> selectStateList = List.filled(20, false);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        width: 300,
        child: CheckboxListTile(
          title: const Text('All'),
          controlAffinity: ListTileControlAffinity.leading,
          value: watch(allStateProvider).state,
          onChanged: (value) {
            watch(allStateProvider).state = value!;
            final List<bool> filledList = List.filled(20, !value);
            watch(selectListValueProvider).state = filledList;
            selectStateList = List.filled(selectStateList.length, value);
            print(watch(selectListValueProvider).state);
          },
        ),
      ),
      FutureBuilder(
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
                      selectStateList = List.filled(technicians.length, false);
                      selectStateList[i] = value!;
                      watch(selectListValueProvider).state = selectStateList;
                      callback(technicians[i]);
                    },
                    // activeColor: MaterialStateProperty.resolveWith(getColor),
                  ),
                ));
              }

              return Wrap(
                children: [...widgetTechList],
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    ]);
  }
}
