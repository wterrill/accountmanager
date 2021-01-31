import 'package:accountmanager/app/home/models/technician.dart';
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
      expect(technician, const Technician(name: 'This Is A Name', id: 'abc'));
    });

    test('missing name', () {
      final technician = Technician.fromMap(const {}, 'abc');
      expect(technician, null);
    });
  });

  group('toMap', () {
    test('valid name, ratePerHour', () {
      const technican = Technician(name: 'Blogging', id: 'abc');
      expect(technican.toMap(),
          {'technician_name': 'Blogging', 'technician_id': 'abc'});
    });
  });

  group('equality', () {
    test('different properties, equality returns false', () {
      const technician1 = Technician(name: 'DifferentName', id: 'abc');
      const technician2 = Technician(name: 'SameName', id: 'abc');
      expect(technician1 == technician2, false);
    });
    test('same properties, equality returns true', () {
      const technician1 = Technician(name: 'SameName', id: 'abc');
      const technician2 = Technician(name: 'SameName', id: 'abc');
      expect(technician1 == technician2, true);
    });
  });

  group('props test', () {
    test('different properties, equality returns false', () {
      const technician1 = Technician(name: 'Blogging1', id: 'abc');
      expect(listEquals(technician1.props, ['abc', 'Blogging']), false);
    });
    test('same properties, equality returns true', () {
      const technician1 = Technician(name: 'Blogging', id: 'abc');
      expect(listEquals(technician1.props, ['abc', 'Blogging']), true);
    });
  });
}
