import 'package:accountmanager/utils/authentication.dart';
import 'package:flutter/material.dart';

class AuthDialog extends StatefulWidget {
  AuthDialog({Key key}) : super(key: key);

  @override
  _AuthDialogState createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog> {
  TextEditingController textControllerEmail;
  FocusNode textFocusNodeEmail;
  bool _isEditingEmail = false;
  TextEditingController textControllerPassword;
  FocusNode textFocusNodePassword;
  bool _isEditingPassword = false;
  bool _isRegistering = false;

  void initState() {
    textControllerEmail = TextEditingController();
    textControllerEmail.text = null;
    textFocusNodeEmail = FocusNode();
    textControllerPassword = TextEditingController();
    textControllerPassword.text = null;
    textFocusNodePassword = FocusNode();

    super.initState();
  }

  String _validateEmail(String value) {
    value = value.trim();

    if (textControllerEmail.text != null) {
      if (value.isEmpty) {
        return 'Email can\'t be empty';
      } else if (!value.contains(RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+_/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
        return 'Enter a correct email address';
      }
    }
    return null;
  }

  String _validatePassword(String value) {
    value = value.trim();

    if (textControllerEmail.text != null) {
      if (value.isEmpty) {
        return 'Email can\'t be empty';
      } else if (!value.contains(RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+_/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
        return 'Enter a correct email address';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Email address'),
          TextField(
            focusNode: textFocusNodeEmail,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            controller: textControllerEmail,
            onChanged: (value) {
              setState(() {
                _isEditingEmail = true;
              });
            },
            onSubmitted: (value) {
              textFocusNodeEmail.unfocus();
              FocusScope.of(context).requestFocus(textFocusNodePassword);
            },
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blueGrey[800], width: 3),
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.blueGrey[300]),
              hintText: 'Email',
              fillColor: Colors.white,
              errorText: _isEditingEmail
                  ? _validateEmail(textControllerEmail.text)
                  : null,
              errorStyle: TextStyle(fontSize: 12, color: Colors.redAccent),
            ),
          ),

          Text('Password'),
          TextField(
            focusNode: textFocusNodePassword,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.next,
            controller: textControllerPassword,
            onChanged: (value) {
              setState(() {
                _isEditingPassword = true;
              });
            },
            onSubmitted: (value) {
              textFocusNodePassword.unfocus();
              FocusScope.of(context).requestFocus(textFocusNodeEmail);
            },
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blueGrey[800], width: 3),
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.blueGrey[300]),
              hintText: 'Password',
              fillColor: Colors.white,
              errorText: _isEditingPassword
                  ? _validateEmail(textControllerPassword.text)
                  : null,
              errorStyle: TextStyle(fontSize: 12, color: Colors.redAccent),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  width: double.maxFinite,
                  child: FlatButton(
                    color: Colors.blueGrey[800],
                    hoverColor: Colors.blueGrey[900],
                    highlightColor: Colors.black,
                    onPressed: () async {
                      if (_validateEmail(textControllerEmail.text) == null &&
                          _validatePassword(textControllerPassword.text) ==
                              null) {
                        setState(() {
                          _isRegistering = true;
                        });
                        var result = await registerWithEmailPassword(
                            textControllerEmail.text,
                            textControllerPassword.text);

                        print(result);
                      }
                      setState(() {
                        _isRegistering = false;
                        _isEditingEmail = false;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: _isRegistering
                          ? SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ))
                          : Text('Sign Up',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white)),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  width: double.maxFinite,
                  child: FlatButton(
                    color: Colors.blueGrey[800],
                    hoverColor: Colors.blueGrey[900],
                    highlightColor: Colors.black,
                    onPressed: () async {
                      if (_validateEmail(textControllerEmail.text) == null &&
                          _validatePassword(textControllerPassword.text) ==
                              null) {
                        setState(() {
                          _isRegistering = true;
                        });
                        var result = await signInWithEmailPassword(
                            textControllerEmail.text,
                            textControllerPassword.text);

                        print(result);
                      }
                      setState(() {
                        _isRegistering = false;
                        _isEditingEmail = false;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: _isRegistering
                          ? SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ))
                          : Text('Log In',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Center(child: GoogleButton())
        ],
      )),
    ));
  }
}
