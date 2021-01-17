import 'package:accountmanager/app/home/models/assignedTbr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

import '../../top_level_providers.dart';

final assignedTbrStreamProvider =
    StreamProvider.autoDispose<List<AssignedTBR>>((ref) {
  final database = ref.watch(databaseProvider);
  return database?.assignedTbrStream() ?? const Stream.empty();
});

class Test2 extends ConsumerWidget {
  int number = 0;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    number++;
    final assignedTbrAsyncValue = watch(assignedTbrStreamProvider);
    print('assignedTbrAsyncValue.data = ${assignedTbrAsyncValue.data}');
    return Container(color: Colors.blue, child: Text(number.toString()));
  }
}
