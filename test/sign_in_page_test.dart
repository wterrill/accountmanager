import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/app/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:accountmanager/routing/app_router.dart';

import 'auth_mock.dart';
import 'mocks.dart';

void main() {
  setupFirebaseAuthMocks();
  group('sign-in page', () {
    MockFirebaseAuth mockFirebaseAuth;
    MockNavigatorObserver mockNavigatorObserver;

    setUp(() async {
      mockFirebaseAuth = MockFirebaseAuth();
      mockNavigatorObserver = MockNavigatorObserver();
      await Firebase.initializeApp();
    });

    Future<void> pumpSignInPage(WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            firebaseAuthProvider
                .overrideWithProvider(Provider((ref) => mockFirebaseAuth)),
          ],
          child: Consumer(builder: (context, watch, __) {
            final firebaseAuth = watch(firebaseAuthProvider);
            return MaterialApp(
              home: SignInPage(),
              onGenerateRoute: (settings) =>
                  AppRouter.onGenerateRoute(settings, firebaseAuth, context),
              navigatorObservers: [mockNavigatorObserver],
            );
          }),
        ),
      );
      // didPush is called once when the widget is first built
      verify(mockNavigatorObserver.didPush(any, any)).called(1);
    }

    testWidgets('email & password navigation', (tester) async {
      await pumpSignInPage(tester);

      final emailPasswordButton =
          find.byKey(SignInPageContents.emailPasswordButtonKey);
      expect(emailPasswordButton, findsOneWidget);

      await tester.tap(emailPasswordButton);
      await tester.pumpAndSettle();

      verify(mockNavigatorObserver.didPush(any, any)).called(1);
    });
  });
}
