import 'package:accountmanager/appLogic/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<User>(
        builder: (_, user, __) {
          if (user == null) {
            return Text('not signed in');
          } else {
            return Text('signed in');
          }
        },
      ),
    );
  }
}
