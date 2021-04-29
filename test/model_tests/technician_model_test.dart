import 'package:accountmanager/models/technician.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';

void main() {
  print('STARTED create_tech_test.dart');
  group('fromMap tests', () {
    test('null data', () {
      final technician = Technician.fromMap(null, 'abc');
      expect(technician, null);
    });
    test('technician with all properties', () {
      final technician = Technician.fromMap(
          const {'technician_name': 'This Is A Name', 'technician_id': 'abc'},
          'abc');
      expect(
          technician,
          const Technician(
            firstName: 'This Is A Name',
            lastName: 'this is a last name',
            id: 'abc',
            email: 'abe@123.com',
          ));
    });

    test('missing name', () {
      final technician = Technician.fromMap(const {}, 'abc');
      expect(technician, null);
    });
  });

  group('toMap', () {
    test('valid name, ratePerHour', () {
      const technican = Technician(
          firstName: 'Blogging',
          lastName: 'this is a last name',
          id: 'abc',
          email: 'abe@123.com');
      expect(technican.toMap(),
          {'technician_name': 'Blogging', 'technician_id': 'abc'});
    });
  });

  group('equality', () {
    test('different properties, equality returns false', () {
      const technician1 = Technician(
          firstName: 'DifferentName',
          lastName: 'this is a last name',
          email: 'abe@123.com',
          id: 'abc');
      const technician2 = Technician(
        firstName: 'SameName',
        lastName: 'this is a last name',
        id: 'abc',
        email: 'abe@123.com',
      );
      expect(technician1 == technician2, false);
    });
    test('same properties, equality returns true', () {
      const technician1 = Technician(
        firstName: 'SameName',
        lastName: 'this is a last name',
        id: 'abc',
        email: 'abe@123.com',
      );
      const technician2 = Technician(
        firstName: 'SameName',
        lastName: 'this is a last name',
        id: 'abc',
        email: 'abe@123.com',
      );
      expect(technician1 == technician2, true);
    });
  });

  group('props test', () {
    test('different properties, equality returns false', () {
      const technician1 = Technician(
        firstName: 'Blogging1',
        lastName: 'this is a last name',
        id: 'abc',
        email: 'abe@123.com',
      );
      expect(listEquals(technician1.props, ['abc', 'Blogging']), false);
    });
    test('same properties, equality returns true', () {
      const technician1 = Technician(
        firstName: 'Blogging',
        lastName: 'this is a last name',
        id: 'abc',
        email: 'abe@123.com',
      );
      expect(listEquals(technician1.props, ['abc', 'Blogging']), true);
    });
  });
}
