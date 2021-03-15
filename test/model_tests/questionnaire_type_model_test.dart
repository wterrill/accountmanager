import 'package:accountmanager/models/questionnaire_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';

void main() {
  print('STARTED questionnaire_type_model_test.dart');
  group('fromMap tests', () {
    test('null data', () {
      final questionnaireType1 = QuestionnaireType.fromMap(null);
      expect(questionnaireType1, null);
    });
    test('with all properties', () {
      final Map<String, String> goodMap = {
        'questionnaireType_id': 'TBR id',
        'questionnaireType_name': 'TBR'
      };
      final questionnaireType1 = QuestionnaireType.fromMap(goodMap);
      const questionnaireType2 = QuestionnaireType(id: 'TBR id', name: 'TBR');
      expect(
        questionnaireType1,
        questionnaireType2,
      );
    });

    test('missing property', () {
      final questionnaireType1 = QuestionnaireType.fromMap(const {});
      expect(questionnaireType1, null);
    });
  });

  group('toMap', () {
    test('valid questionnaireType creation', () {
      const questionnaireType1 = QuestionnaireType(name: 'Blogging', id: 'abc');
      expect(questionnaireType1.toMap(), {
        'questionnaireType_name': 'Blogging',
        'questionnaireType_id': 'abc'
      });
    });
  });

  group('equality', () {
    test('different properties, equality returns false', () {
      const questionnaireType1 =
          QuestionnaireType(name: 'DifferentName', id: 'abc');
      const questionnaireType2 = QuestionnaireType(name: 'SameName', id: 'abc');
      expect(questionnaireType1 == questionnaireType2, false);
    });
    test('same properties, equality returns true', () {
      const questionnaireType1 = QuestionnaireType(name: 'SameName', id: 'abc');
      const questionnaireType2 = QuestionnaireType(name: 'SameName', id: 'abc');
      expect(questionnaireType1 == questionnaireType2, true);
    });
  });

  group('props test', () {
    test('different properties, equality returns false', () {
      const questionnaireType1 =
          QuestionnaireType(name: 'Blogging1', id: 'abc');
      expect(listEquals(questionnaireType1.props, ['abc', 'Blogging']), false);
    });
    test('same properties, equality returns true', () {
      const questionnaireType1 = QuestionnaireType(name: 'Blogging', id: 'abc');
      expect(listEquals(questionnaireType1.props, ['abc', 'Blogging']), true);
    });
  });
}
