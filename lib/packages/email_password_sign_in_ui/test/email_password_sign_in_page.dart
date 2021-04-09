// part of email_password_sign_in_ui;
import 'dart:math';
import 'package:accountmanager/common_utilities/buttonConverter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:accountmanager/packages/email_password_sign_in_ui/test/email_password_sign_in_model.dart';
import '../../alert_dialogs/alert_dialogs.dart';
import '../../custom_buttons/custom_buttons.dart';
import '../../email_password_sign_in_ui/test/email_password_sign_in_strings.dart';

String filename = 'email_password_sign_in_page.dart: ';

class EmailPasswordSignInPage extends StatefulWidget {
  const EmailPasswordSignInPage(
      {Key key, @required this.model, this.onSignedIn})
      : super(key: key);
  final EmailPasswordSignInModel model;
  final VoidCallback onSignedIn;

  factory EmailPasswordSignInPage.withFirebaseAuth(FirebaseAuth firebaseAuth,
      {@required VoidCallback onSignedIn}) {
    return EmailPasswordSignInPage(
      model: EmailPasswordSignInModel(firebaseAuth: firebaseAuth),
      onSignedIn: onSignedIn,
    );
  }

  @override
  _EmailPasswordSignInPageState createState() =>
      _EmailPasswordSignInPageState();
}

class _EmailPasswordSignInPageState extends State<EmailPasswordSignInPage> {
  final FocusScopeNode _node = FocusScopeNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  EmailPasswordSignInModel get model => widget.model;

  @override
  void initState() {
    super.initState();
    // Temporary workaround to update state until a replacement for ChangeNotifierProvider is found
    model.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    model.dispose();
    _node.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showSignInError(EmailPasswordSignInModel model, dynamic exception) {
    showExceptionAlertDialog(
      context: context,
      title: model.errorAlertTitle,
      exception: exception,
    );
  }

  Future<void> _submit() async {
    try {
      final bool success = await model.submit();
      print('success=$success');
      if (success) {
        if (model.formType == EmailPasswordSignInFormType.forgotPassword) {
          await showAlertDialog(
            context: context,
            title: EmailPasswordSignInStrings.resetLinkSentTitle,
            content: EmailPasswordSignInStrings.resetLinkSentMessage,
            defaultActionText: EmailPasswordSignInStrings.ok,
          );
        } else {
          if (widget.onSignedIn != null) {
            widget.onSignedIn();
          }
        }
      }
    } catch (e) {
      _showSignInError(model, e);
    }
  }

  void _emailEditingComplete() {
    if (model.canSubmitEmail) {
      _node.nextFocus();
    }
  }

  void _passwordEditingComplete() {
    if (!model.canSubmitEmail) {
      _node.previousFocus();
      return;
    }
    _submit();
  }

  void _updateFormType(EmailPasswordSignInFormType formType) {
    model.updateFormType(formType);
    _emailController.clear();
    _passwordController.clear();
  }

  Widget _buildLogo() {
    return Image.asset('assets/images/sign_in_logo.png');
  }

  Widget _buildEmailField() {
    // _emailController.text = 'a@b.com';
    // _passwordController.text = 'asdfghjkl;\'';
    return TextFormField(
      key: const Key('email'),
      controller: _emailController,
      decoration: InputDecoration(
        labelText: EmailPasswordSignInStrings.emailLabel,
        hintText: EmailPasswordSignInStrings.emailHint,
        errorText: model.emailErrorText,
        enabled: !model.isLoading,
      ),
      autocorrect: false,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      keyboardAppearance: Brightness.light,
      onEditingComplete: _emailEditingComplete,
      inputFormatters: <TextInputFormatter>[
        model.emailInputFormatter,
      ],
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      key: const Key('password'),
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: model.passwordLabelText,
        errorText: model.passwordErrorText,
        enabled: !model.isLoading,
      ),
      obscureText: true,
      autocorrect: false,
      textInputAction: TextInputAction.done,
      keyboardAppearance: Brightness.light,
      onEditingComplete: _passwordEditingComplete,
    );
  }

  Widget _buildContent() {
    return FocusScope(
      node: _node,
      child: Form(
        onChanged: () => model.updateWith(
            email: _emailController.text, password: _passwordController.text),
        child: Container(
          width: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildLogo(),
              const SizedBox(height: 8.0),
              _buildEmailField(),
              if (model.formType !=
                  EmailPasswordSignInFormType.forgotPassword) ...<Widget>[
                const SizedBox(height: 8.0),
                _buildPasswordField(),
              ],
              const SizedBox(height: 8.0),
              if (model.formType == EmailPasswordSignInFormType.signIn)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlatButtonX(
                      keyx: const Key('tertiary-button'),
                      childx: const Text(
                          EmailPasswordSignInStrings.forgotPasswordQuestion),
                      onPressedx: model.isLoading
                          ? null
                          : () => _updateFormType(
                              EmailPasswordSignInFormType.forgotPassword),
                    ),
                  ],
                ),
              const SizedBox(height: 32.0),
              FormSubmitButton(
                // shape: RoundedRectangleBorder(
                //     side: const BorderSide(color: Colors.black, width: 0.5),
                //     borderRadius: BorderRadius.circular(25)),

                key: const Key('primary-button'),
                text: model.primaryButtonText,
                loading: model.isLoading,
                onPressed: model.isLoading ? null : _submit,
              ),
              const SizedBox(height: 8.0),
              FlatButtonX(
                keyx: const Key('secondary-button'),
                childx: Text(model.secondaryButtonText),
                onPressedx: model.isLoading
                    ? null
                    : () => _updateFormType(model.secondaryActionFormType),
              ),
              const SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 2.0,
      //   title: Text("BEER"),
      // ),
      backgroundColor: Colors.grey[200],
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/sign_in_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Center(
            child: LayoutBuilder(builder: (context, constraints) {
              return Container(
                width: min(constraints.maxWidth, 500),
                padding: const EdgeInsets.fromLTRB(16.0, 200.0, 16.0, 16.0),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black, width: 0.5),
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(64.0, 32.0, 64.0, 32.0),
                    child: _buildContent(),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
