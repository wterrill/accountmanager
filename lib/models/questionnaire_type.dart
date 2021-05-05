import 'package:accountmanager/models/model_interface.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class QuestionnaireType extends Equatable implements DropdownModel {
  const QuestionnaireType({required this.name, required this.id});
  final String name;
  final String id;

  @override
  List<Object> get props => [id, name];

  @override
  bool get stringify => true;

  factory QuestionnaireType.fromMap(Map<String, dynamic>? data) {
    QuestionnaireType errorQuestionaireType =
        QuestionnaireType(id: DateTime.now(), name: 'Error');
    if (data == null) {
      return errorQuestionaireType;
    }

    final optionName = data['questionnaireType_name'] as String?;
    if (optionName == null) {
      return errorQuestionaireType;
    }

    final optionid = data['questionnaireType_id'] as String?;
    if (optionid == null) {
      return errorQuestionaireType;
    }
    return QuestionnaireType(name: optionName, id: optionid);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'questionnaireType_id': id,
      'questionnaireType_name': name,
    };
  }

  @override
  String toString() => name;

  String toDeluxeString() => toMap().toString();

  @override
  String toDropDownString() => name;
}
