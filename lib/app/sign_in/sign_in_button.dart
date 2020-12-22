// import 'package:custom_buttons/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:starter_architecture_flutter_firebase/packages/custom_buttons/custom_buttons.dart';
// import 'package:starter_architecture_flutter_firebase/packages/custom_buttons/lib/custom_buttons.dart';

class SignInButton extends CustomRaisedButton {
  SignInButton({
    Key key,
    @required String text,
    @required Color color,
    @required VoidCallback onPressed,
    Color textColor = Colors.black87,
    double height = 50.0,
  }) : super(
          key: key,
          child: Text(text, style: TextStyle(color: textColor, fontSize: 16.0)),
          color: color,
          textColor: textColor,
          height: height,
          onPressed: onPressed,
        );
}
