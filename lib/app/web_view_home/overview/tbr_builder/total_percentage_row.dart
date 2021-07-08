import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/models/tbr_in_progress.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TotalPercentageRow extends ConsumerWidget {
  const TotalPercentageRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    TBRinProgress? tbrInProgress = watch(tbrInProgressProvider).state;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Total Completed: '),
        Text((tbrInProgress!.totalPercent * 100).toStringAsFixed(0)),
        const Text('%')
      ],
    );
  }
}
