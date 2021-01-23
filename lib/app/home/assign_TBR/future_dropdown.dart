import 'package:accountmanager/common_utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

import 'package:accountmanager/services/firestore_database.dart';

import '../../top_level_providers.dart';

// typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class FutureDropdown<T> extends StatefulWidget {
  const FutureDropdown(
      {Key key,
      @required this.future,
      @required this.onSelected,
      @required this.onSelectedChange,
      @required this.hint,
      this.selectedData})
      : super(key: key);
  final Future<List<T>> future;
  final VoidCallback onSelected;
  final Function(T) onSelectedChange;
  final String hint;
  final T selectedData;

  @override
  _FutureDropdownState<T> createState() => _FutureDropdownState<T>();
}

class _FutureDropdownState<T> extends State<FutureDropdown> {
  T _selectedItem;
  String selectedItemName = '';
  String hint;
  @override
  void initState() {
    if (widget.selectedData != null) {
      _selectedItem = widget.selectedData as T;
    }
    hint = widget.hint ?? 'Select Item';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Type type = typeOf<T>();
    print('********************************** T type()= ${typeOf<T>()}');
    return DropdownButtonHideUnderline(
      child: FutureBuilder<List<T>>(
        future: widget.future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container();
          } else if (snapshot.hasData) {
            // print(snapshot.data);
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
                widget.onSelected();
                widget.onSelectedChange(_selectedItem);
              },
              hint: (_selectedItem == null)
                  ? Text(hint)
                  : Text(
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
