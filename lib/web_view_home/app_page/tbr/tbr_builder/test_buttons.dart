import 'dart:math';
import 'package:accountmanager/app/home/models/tbr.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';

class TestButtonRow extends ConsumerWidget {
  const TestButtonRow({Key key, this.tbrInProgress}) : super(key: key);
  final TBRinProgress tbrInProgress;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildTestButton(
          context: context,
          text: 'Fill out all YES',
          boolList: [true, false, false],
          color: Colors.green,
        ),
        buildTestButton(
          context: context,
          text: 'Fill out all No',
          boolList: [false, true, false],
          color: Colors.red,
        ),
        buildTestButton(
          context: context,
          text: 'Fill out all N/A',
          boolList: [false, false, true],
          color: Colors.grey,
        ),
        buildTestButton(
            context: context,
            text: 'fill out all Random',
            color: Colors.yellow,
            onPressedNew: () {
              for (final String key in tbrInProgress.answers.keys) {
                final int randomNumber = Random().nextInt(3);
                final List<bool> temp = [false, false, false];
                temp[randomNumber] = true;
                tbrInProgress.answers[key] = temp;
              }
              context.read(newTbrInProgressProvider).state = tbrInProgress;
            }),
      ],
    );
  }

  TextButton buildTestButton(
      {BuildContext context,
      String text,
      List<bool> boolList,
      Function onPressedNew,
      Color color}) {
    Function onPressed = () {
      for (final String key in tbrInProgress.answers.keys) {
        tbrInProgress.answers[key] = boolList;
      }
      context.read(newTbrInProgressProvider).state = tbrInProgress;
    };
    if (onPressedNew != null) {
      onPressed = onPressedNew;
    }
    return TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(color)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text ?? ''),
        ),
        onPressed: onPressed);
  }
}
