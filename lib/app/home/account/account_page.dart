import 'dart:async';

import 'package:accountmanager/app/home/assign_TBR/assign_tbr_page.dart';
import 'package:accountmanager/app/home/overview/overview_page.dart';
import 'package:accountmanager/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/common_widgets/avatar.dart';
import 'package:accountmanager/constants/keys.dart';
import 'package:accountmanager/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:accountmanager/packages/alert_dialogs/alert_dialogs.dart';

class AccountPage extends StatelessWidget {
  Future<void> _signOut(BuildContext context, FirebaseAuth firebaseAuth) async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      unawaited(showExceptionAlertDialog(
        context: context,
        title: Strings.logoutFailed,
        exception: e,
      ));
    }
  }

  Future<void> _confirmSignOut(
      BuildContext context, FirebaseAuth firebaseAuth) async {
    final bool didRequestSignOut = await showAlertDialog(
          context: context,
          title: Strings.logout,
          content: Strings.logoutAreYouSure,
          cancelActionText: Strings.cancel,
          defaultActionText: Strings.logout,
        ) ??
        false;
    if (didRequestSignOut == true) {
      await _signOut(context, firebaseAuth);
    }
  }

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = context.read(firebaseAuthProvider);
    final user = firebaseAuth.currentUser;
    return Scaffold(
        appBar: AppBar(
          title: const Text(Strings.accountPage),
          actions: <Widget>[
            FlatButton(
              key: const Key(Keys.logout),
              child: const Text(
                Strings.logout,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () => _confirmSignOut(context, firebaseAuth),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(130.0),
            child: _buildUserInfo(user),
          ),
        ),
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        Consumer(builder: (context, watch, child) {
          final greeting = watch(greetingProvider);
          return Text(greeting);
        }),
        Consumer(builder: (context, watch, child) {
          final incrementNotifier = watch(incrementProvider);
          return Text(incrementNotifier._value.toString());
        }),
        RawMaterialButton(
            child: const Text('increment'),
            onPressed: () {
              context.read(incrementProvider).increment();
            }),
        Consumer(builder: (context, watch, client) {
          final responseAsyncValue = watch(responseProvider('swimming.com'));
          return responseAsyncValue.map(
              data: (_) => Text(_.value),
              loading: (_) => const CircularProgressIndicator(),
              error: (_) => Text(_.error.toString(),
                  style: const TextStyle(color: Colors.red)));
        }),
        const SizedBox(height: 100),
        RawMaterialButton(
          child: const Text('New Page'),
          fillColor: Colors.blue,
          onPressed: () {
            // Navigator.of(context).push<OverviewPage>(MaterialPageRoute(
            //     builder: (context) =>
            //         const OverviewPage(data: 'hello there')));

            // Navigator.of(context).pushAndRemoveUntil<OverviewPage>(
            //   MaterialPageRoute(
            //       builder: (context) => const OverviewPage(data: 'weird')),
            //   ModalRoute.withName('/'),
            // );

            // Navigator.of(context).pushAndRemoveUntil<OverviewPage>(
            //     MaterialPageRoute(
            //         builder: (context) => const OverviewPage(data: 'weird')),
            //     (Route<dynamic> route) => false);

            // Navigator.of(context).pushNamed('/second');
          },
        ),
      ],
    );
  }

  Widget _buildUserInfo(User user) {
    return Column(
      children: [
        Avatar(
          photoUrl: user.photoURL,
          radius: 50,
          borderColor: Colors.black54,
          borderWidth: 2.0,
        ),
        const SizedBox(height: 8),
        if (user.displayName != null)
          Text(
            user.displayName,
            style: const TextStyle(color: Colors.white),
          ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class FakeHttpClient {
  Future<String> get(String url) async {
    await Future.delayed(const Duration(seconds: 5));
    return 'Response from $url';
  }
}

final fakeHttpClientProvider = Provider((ref) => FakeHttpClient());
final responseProvider =
    FutureProvider.autoDispose.family<String, String>((ref, url) async {
  final httpClient = ref.watch(fakeHttpClientProvider);
  return httpClient.get(url);
});

class IncrementNotifier extends ChangeNotifier {
  int _value = 0;
  int get value => _value;

  void increment() {
    _value++;
    notifyListeners();
  }
}
