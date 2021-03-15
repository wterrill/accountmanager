import 'package:accountmanager/models/company.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';

void main() {
  print('STARTED company_model_test.dart');
  group('fromMap tests', () {
    test('null data', () {
      final company1 = Company.fromMap(null, 'abc');
      expect(company1, null);
    });
    test('with all properties', () {
      final company1 = Company.fromMap(const {
        'company_name': 'a company',
      }, 'abc');
      const company2 = Company(id: 'abc', name: 'a company');
      expect(
        company1,
        company2,
      );
    });

    test('missing name', () {
      final company1 = Company.fromMap(const {}, 'abc');
      expect(company1, null);
    });
  });

  group('toMap', () {
    test('valid company creation', () {
      const company1 = Company(name: 'Blogging', id: 'abc');
      expect(
          company1.toMap(), {'company_name': 'Blogging', 'company_id': 'abc'});
    });
  });

  group('equality', () {
    test('different properties, equality returns false', () {
      const company1 = Company(name: 'DifferentName', id: 'abc');
      const company2 = Company(name: 'SameName', id: 'abc');
      expect(company1 == company2, false);
    });
    test('same properties, equality returns true', () {
      const company1 = Company(name: 'SameName', id: 'abc');
      const company2 = Company(name: 'SameName', id: 'abc');
      expect(company1 == company2, true);
    });
  });

  group('props test', () {
    test('different properties, equality returns false', () {
      const company1 = Company(name: 'Blogging1', id: 'abc');
      expect(listEquals(company1.props, ['abc', 'Blogging']), false);
    });
    test('same properties, equality returns true', () {
      const company1 = Company(name: 'Blogging', id: 'abc');
      expect(listEquals(company1.props, ['abc', 'Blogging']), true);
    });
  });
}
