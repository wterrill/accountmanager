import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/app/web_view_home/account/account_page.dart';
import 'package:accountmanager/constants/strings.dart';
import 'package:accountmanager/packages/alert_dialogs/alert_dialogs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:accountmanager/buildTime/flutter_date.dart';
import 'package:accountmanager/buildTime/flutter_version.dart';
import 'package:pedantic/pedantic.dart';

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth firebaseAuth = context.read(firebaseAuthProvider);
    final user = firebaseAuth.currentUser!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Container(
            width: 500,
            height: 150,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Image.asset(
                'assets/images/acct_manager_white.gif',
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    child: CircleAvatar(
                        child: Container(
                      width: 80,
                      height: 80,
                      child: Center(
                        child: Text(
                          user.email![0].toUpperCase(),
                          style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 48,
                              fontFamily: 'Monoton'),
                        ),
                      ),
                    )),
                  ),
                  const SizedBox(width: 15),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(user.email!,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ],
              ),
              Container(
                width: 300,
                height: 120,
                // color: Colors.red,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    elevation: 300,
                    icon: const Visibility(
                        visible: false, child: Icon(Icons.arrow_downward)),
                    // icon: Icon(Icons.favorite),
                    items: <String>[
                      'My Settings',
                      'About Account Manager',
                      'Sign Out',
                    ].map((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value == 'Sign Out') {
                        _confirmSignOut(context, firebaseAuth);
                      }
                      if (value == 'My Settings') {
                        context.read(widgetProvider).state = AccountWebPage2();
                      }
                      if (value == 'About Account Manager') {
                        _showVersion(context);
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
    // );
  }
}

Future<void> _showVersion(BuildContext context) async {
  try {
    final Map<String, dynamic>? result = await showWidgetDialog(
      defaultActionText: '',
      cancelActionText: '',
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
