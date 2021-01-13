import 'package:accountmanager/app/home/models/technician.dart';
import 'package:accountmanager/services/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

import '../../top_level_providers.dart';

class FutureDropdown extends StatefulWidget {
  const FutureDropdown({Key key}) : super(key: key);

  @override
  _FutureDropdownState createState() => _FutureDropdownState();
}

class _FutureDropdownState extends State<FutureDropdown> {
  Technician _selectedItem;
  String selectedItemName = '';

  @override
  Widget build(BuildContext context) {
    final FirestoreDatabase database = context.read(databaseProvider);
    return DropdownButtonHideUnderline(
      child: FutureBuilder<List<Technician>>(
        future: database.technicianStream().first,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container();
          } else if (snapshot.hasData) {
            print(snapshot.data);
            final List<DropdownMenuItem<Technician>> list = [];
            final Map<int, dynamic> dropDownItemsMap = {};

            for (final Technician technician in snapshot.data) {
              //listItemNames.add(branchItem.itemName);
              final int index = snapshot.data.indexOf(technician);
              dropDownItemsMap[index] = technician;

              list.add(DropdownMenuItem<Technician>(
                  child: Text(technician.name), value: technician));
            }

            return DropdownButton<Technician>(
              items: list,
              value: _selectedItem,
              onChanged: (selected) {
                _selectedItem = selected;
                setState(() {
                  selectedItemName = _selectedItem.name;
                });
              },
              hint: Text(
                selectedItemName,
                style: const TextStyle(color: Colors.blue),
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
