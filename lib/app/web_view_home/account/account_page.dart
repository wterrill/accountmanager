import 'dart:async';

import 'package:accountmanager/buildTime/flutter_date.dart';
import 'package:accountmanager/buildTime/flutter_version.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/common_widgets/avatar.dart';
import 'package:accountmanager/constants/keys.dart';
import 'package:accountmanager/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:accountmanager/packages/alert_dialogs/alert_dialogs.dart';

class AccountWebPage extends StatelessWidget {
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
    return AppBar(
      title: const Text(Strings.accountPage),
      actions: <Widget>[
        TextButton(
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
        const SizedBox(width: 50),
        TextButton(
          child: const Text(
            'Version',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
            ),
          ),
          onPressed: () => _showVersion(context),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(130.0),
        child: _buildUserInfo(user),
      ),
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

Future<void> _showVersion(BuildContext context) async {
  try {
    final Map<String, dynamic> result = await showWidgetDialog(
      context: context,
      title: 'Version',
      widget: FractionallySizedBox(
        heightFactor: 0.1,
        child: Column(
          children: const <Widget>[
            Text('Build date: $buildDate'),
            Text('App Version: $appVersion')
          ],
        ),
      ),
      // defaultActionText: '',
      // cancelActionText: '',
    );

    if (result != null && (result['result']) == 'true') {
      // print('result = $result');
    }
  } catch (e) {
    unawaited(showExceptionAlertDialog(
      context: context,
      title: 'Operation failed',
      exception: e,
    ));
  }
}
