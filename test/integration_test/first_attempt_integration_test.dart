// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';

// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();

//   testWidgets('failing test example', (WidgetTester tester) async {
//     expect(2 + 2, equals(4));
//   });
// }

import 'package:accountmanager/constants/keys.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// The application under test.
import 'package:accountmanager/main.dart' as app;

// import 'package:integration_test_example/main.dart' as app;

void main() {
  group('end-to-end test', () {
    setUpAll(() async {
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    });

    testWidgets('tap on the floating action button; verify counter',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Finds the floating action button to tap on.
      final Finder fab = find.byKey(Key(Keys.getStarted));

      // Emulate a tap on the floating action button.
      await tester.tap(fab);

      await tester.pumpAndSettle();

      expect(find.text('Sign in'), findsOneWidget);
    });
  });
}
