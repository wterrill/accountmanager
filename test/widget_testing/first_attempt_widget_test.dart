import 'package:accountmanager/app/home/account/account_page.dart';
import 'package:accountmanager/app/home/assign_TBR/delete_me.dart';
import 'package:accountmanager/constants/keys.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
    await tester.pumpWidget(MyWidget(title: 'T', message: 'M'));
    final titleFinder = find.text('T');
    final messageFinder = find.text('M');

    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });

  // testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
  //   await tester.pumpWidget(AccountPage());

  // when(mockAuth.signInWithCredential(any))
  //     .thenAnswer((_) => Future<UserCredential>.value(MockUserCredential()));

  // final buttonFinder = find.byKey(const Key(Keys.logout));
  // buttonFinder.
//     await tester.tap(buttonFinder);
// // Rebuild the Widget after the state has changed
//     await tester.pump();

//     final titleFinder = find.text('Are you that you want to logout?');

//     expect(titleFinder, findsOneWidget);
  // });
}
