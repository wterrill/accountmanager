import 'dart:math';
import 'package:accountmanager/models/tbr.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

TBRinProgress tbrInProgress;

class TestButtonRow extends ConsumerWidget {
  const TestButtonRow({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    tbrInProgress = watch(tbrInProgressProvider).state;
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
              tbrInProgress.updatePercentages();
              context.read(tbrInProgressProvider).state = tbrInProgress;
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
      tbrInProgress.updatePercentages();
      context.read(tbrInProgressProvider).state = tbrInProgress;
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
