import 'package:flutter_test/flutter_test.dart';

import '../firebase_auth_service.dart';

void main() {
  group('User', () {
    test('null uid throws exception', () {
      expect(AppUser(uid: null), throwsAssertionError);
    }, skip: true);
  });
}
