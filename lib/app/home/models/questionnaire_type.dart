import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class QuestionnaireType extends Equatable {
  const QuestionnaireType({@required this.option});
  final String option;

  @override
  List<Object> get props => [option];

  @override
  bool get stringify => true;

  factory QuestionnaireType.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }
    final optionString = data['option'] as String;
    if (optionString == null) {
      return null;
    }
    return QuestionnaireType(option: optionString);
  }

  Map<String, dynamic> toMap() {
    return {
      'option': option,
    };
  }

  @override
  String toString() => option;
}
