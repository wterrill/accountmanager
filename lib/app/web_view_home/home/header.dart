import 'package:accountmanager/app/top_level_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Header extends StatefulWidget {
  const Header({Key key}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth firebaseAuth = context.read(firebaseAuthProvider);
    final user = firebaseAuth.currentUser;
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
          child: Row(
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
                      user.email[0].toUpperCase(),
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
                child: Text(user.email,
                    style: const TextStyle(color: Colors.white, fontSize: 16)),
              )
            ],
          ),
        )
      ],
    );
    // );
  }
}
