import 'package:accountmanager/app/home/models/status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';

void main() {
  print('STARTED status_model_test.dart');
  group('fromMap tests', () {
    test('null data', () {
      final status1 = Status.fromMap(null);
      expect(status1, null);
    });
    test('with all properties', () {
      final Map<String, int> goodMap = {
        'statusIndex': 1,
      };
      final status1 = Status.fromMap(goodMap);
      final status2 = Status(statusIndex: 1);
      expect(
        status1,
        status2,
      );
    });

    test('missing property', () {
      final status1 = Status.fromMap(const {});
      expect(status1, null);
    });
  });

  group('toMap', () {
    test('valid status creation', () {
      final Map<String, int> goodMap = {
        'statusIndex': 1,
      };
      final Status status1 = Status.fromMap(goodMap);
      expect(status1.toMap(), goodMap);
    });
  });

  group('equality', () {
    test('different properties, equality returns false', () {
      final Map<String, int> goodMap = {
        'statusIndex': 1,
      };
      final status1 = Status.fromMap(goodMap);
      final status2 = Status(statusIndex: 2);
      expect(status1 == status2, false);
    });
    test('same properties, equality returns true', () {
      final Map<String, int> goodMap = {
        'statusIndex': 1,
      };
      final status1 = Status.fromMap(goodMap);
      final status2 = Status(statusIndex: 1);
      expect(status1 == status2, true);
    });
  });

  group('props test', () {
    test('different properties, equality returns false', () {
      final status1 = Status(statusIndex: 1);
      expect(listEquals(status1.props, [2]), false);
    });
    test('same properties, equality returns true', () {
      final status1 = Status(statusIndex: 1);
      expect(listEquals(status1.props, [1]), true);
    });
  });
}
