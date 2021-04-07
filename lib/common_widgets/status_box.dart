import 'package:flutter/material.dart';

Widget statusBox(String status) {
  Color boxColor = Colors.yellow;
  if (status == 'Completed') {
    boxColor = Colors.green[300];
  }
  return Container(
    alignment: Alignment.center,
    height: 30,
    width: 100,
    child: Text(status),
    decoration: BoxDecoration(
        color: boxColor,
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(20))),
  );
}
