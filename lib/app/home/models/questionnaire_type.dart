import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class QuestionnaireType extends Equatable {
  const QuestionnaireType({@required this.name, @required this.id});
  final String name;
  final String id;

  @override
  List<Object> get props => [id, name];

  @override
  bool get stringify => true;

  factory QuestionnaireType.fromMap(Map<String, dynamic> data, String id) {
    if (data == null) {
      return null;
    }

    final optionName = data['questionnaireType_name'] as String;
    if (optionName == null) {
      return null;
    }

    final optionid = data['questionnaireType_id'] as String;
    if (optionid == null) {
      return null;
    }
    return QuestionnaireType(name: optionName, id: optionid);
  }

  Map<String, dynamic> toMap() {
    return {
      'questionnaireType_id': id,
      'questionnaireType_name': name,
    };
  }

  @override
  String toString() => name;
}
