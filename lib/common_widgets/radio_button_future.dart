import 'package:accountmanager/models/questionnaire_type.dart';
import 'package:accountmanager/services/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final radioButtonValueProvider = StateProvider<QuestionnaireType>(
    (ref) => const QuestionnaireType(name: 'name', id: 'id'));
typedef RadioButtonCallback = void Function(QuestionnaireType);

class FutureRadioButton extends ConsumerWidget {
  const FutureRadioButton(
      {Key? key, required this.database, required this.callback})
      : super(key: key);
  final FirestoreDatabase database;
  final RadioButtonCallback callback;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return FutureBuilder(
      future: database.questionnaireTypeStream().first,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<QuestionnaireType> data =
              snapshot.data as List<QuestionnaireType>;
          print(data);
          final List<Widget> children = [];
          for (int i = 0; i < data.length; i++) {
            children.add(Container(
              width: 200,
              height: 50,
              child: ListTile(
                title: Text(data[i].name),
                leading: Radio<QuestionnaireType>(
                  value: data[i],
                  groupValue: watch(radioButtonValueProvider).state,
                  onChanged: (value) {
                    watch(radioButtonValueProvider).state = value!;
                    callback(value);
                  },
                ),
              ),
            ));
          }
          return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
