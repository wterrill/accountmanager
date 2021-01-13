import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

import 'package:accountmanager/services/firestore_database.dart';

import '../../top_level_providers.dart';

// typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class FutureDropdown<T> extends StatefulWidget {
  const FutureDropdown({
    Key key,
    @required this.future,
  }) : super(key: key);
  final Future<List<T>> future;

  @override
  _FutureDropdownState<T> createState() => _FutureDropdownState<T>();
}

class _FutureDropdownState<T> extends State<FutureDropdown> {
  T _selectedItem;
  String selectedItemName = '';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: FutureBuilder<List<T>>(
        future: widget.future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container();
          } else if (snapshot.hasData) {
            print(snapshot.data);
            final List<DropdownMenuItem<T>> list = [];
            final Map<int, dynamic> dropDownItemsMap = {};

            for (final T singleData in snapshot.data) {
              //listItemNames.add(branchItem.itemName);
              final int index = snapshot.data.indexOf(singleData);
              dropDownItemsMap[index] = singleData;

              list.add(DropdownMenuItem<T>(
                  child: Text(singleData.toString()), value: singleData));
            }

            return DropdownButton<T>(
              items: list,
              value: _selectedItem,
              onChanged: (selected) {
                _selectedItem = selected;
                setState(() {
                  selectedItemName = _selectedItem.toString();
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
