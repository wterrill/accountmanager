import 'package:accountmanager/app/home/models/technician.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  print('STARTED create_tech_test.dart');
  group('fromMap', () {
    test('null data', () {
      final technician = Technician.fromMap(null, 'abc');
      expect(technician, null);
    });
    test('technician with all properties', () {
      final technician =
          Technician.fromMap(const {'name': 'Blogging', 'id': 'abc'}, 'abc');
      expect(technician, const Technician(name: 'Blogging', id: 'abc'));
    });

    test('missing name', () {
      final technician = Technician.fromMap(const {}, 'abc');
      expect(technician, null);
    });
  });

  group('toMap', () {
    test('valid name, ratePerHour', () {
      const technican = Technician(name: 'Blogging', id: 'abc');
      expect(technican.toMap(), {
        'name': 'Blogging',
      });
    });
  });

  group('equality', () {
    test('different properties, equality returns false', () {
      const technician1 = Technician(name: 'Blogging1', id: 'abc');
      const technician2 = Technician(name: 'Blogging2', id: 'abc');
      expect(technician1 == technician2, false);
    });
    test('same properties, equality returns true', () {
      const technician1 = Technician(name: 'Blogging', id: 'abc');
      const technician2 = Technician(name: 'Blogging', id: 'abc');
      expect(technician1 == technician2, true);
    });
  });
}
