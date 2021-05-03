// part of email_password_sign_in_ui;
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../../email_password_sign_in_ui/test/email_password_sign_in_strings.dart';
import '../../string_validators/string_validators.dart';

String filename = 'email_password_sign_in_model.dart';

enum EmailPasswordSignInFormType { signIn, register, forgotPassword }

class EmailAndPasswordValidators {
  final TextInputFormatter emailInputFormatter =
      ValidatorInputFormatter(editingValidator: EmailEditingRegexValidator());
  final StringValidator emailSubmitValidator = EmailSubmitRegexValidator();

  final TextInputFormatter firstNameInputFormatter = ValidatorInputFormatter(
      editingValidator: FirstNameEditingRegexValidator());
  final StringValidator firstNameSubmitValidator =
      FirstNameSubmitRegexValidator();

  final TextInputFormatter lastNameInputFormatter = ValidatorInputFormatter(
      editingValidator: LastNameEditingRegexValidator());
  final StringValidator lastNameSubmitValidator =
      LastNameSubmitRegexValidator();

  final StringValidator passwordRegisterSubmitValidator =
      MinLengthStringValidator(8);
  final StringValidator passwordSignInSubmitValidator =
      NonEmptyStringValidator();
}

class EmailPasswordSignInModel with EmailAndPasswordValidators, ChangeNotifier {
  EmailPasswordSignInModel({
    required this.firebaseAuth,
    required this.context,
    this.email = '',
    this.password = '',
    this.firstName = '',
    this.lastName = '',
    this.formType = EmailPasswordSignInFormType.signIn,
    this.isLoading = false,
    this.submitted = false,
  });
  final FirebaseAuth? firebaseAuth;
  final BuildContext? context;

  String email;
  String password;
  String firstName;
  String lastName;
  EmailPasswordSignInFormType formType;
  bool isLoading;
  bool submitted;

  Future<bool> submit() async {
    try {
      updateWith(submitted: true);
      if (!canSubmit) {
        return false;
      }
      updateWith(isLoading: true);
      switch (formType) {
        case EmailPasswordSignInFormType.signIn:
          if (firebaseAuth!.currentUser != null) {
            await firebaseAuth!.signOut();
          }
          await firebaseAuth!.signInWithCredential(
              EmailAuthProvider.credential(email: email, password: password));
          break;
        case EmailPasswordSignInFormType.register:
          final UserCredential userCredential = await firebaseAuth!
              .createUserWithEmailAndPassword(email: email, password: password);

          context!.read(registeredProvider).set({
            'firstName': firstName,
            'lastName': lastName,
            'email': email,
            'uid': userCredential.user!.uid
          });

          break;
        case EmailPasswordSignInFormType.forgotPassword:
          await firebaseAuth!.sendPasswordResetEmail(email: email);
          updateWith(isLoading: false);
          break;
      }
      return true;
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  void updateEmail(String email) => updateWith(email: email);

  void updateFirstName(String firstName) => updateWith(firstName: firstName);

  void updateLastName(String lastName) => updateWith(lastName: lastName);

  void updatePassword(String password) => updateWith(password: password);

  void updateFormType(EmailPasswordSignInFormType? formType) {
    updateWith(
      email: '',
      password: '',
      firstName: '',
      lastName: '',
      formType: formType,
      isLoading: false,
      submitted: false,
    );
  }

  void updateWith({
    String? email,
    String? password,
    String? firstName,
    String? lastName,
    EmailPasswordSignInFormType? formType,
    bool? isLoading,
    bool? submitted,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.formType = formType ?? this.formType;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    this.firstName = firstName ?? this.firstName;
    this.lastName = lastName ?? this.lastName;
    notifyListeners();
  }

  String get passwordLabelText {
    if (formType == EmailPasswordSignInFormType.register) {
      return EmailPasswordSignInStrings.password8CharactersLabel;
    }
    return EmailPasswordSignInStrings.passwordLabel;
  }

  String get firstNameLabelText {
    if (formType == EmailPasswordSignInFormType.register) {
      return EmailPasswordSignInStrings.password8CharactersLabel;
    }
    return EmailPasswordSignInStrings.passwordLabel;
  }

  String get lastNameLabelText {
    if (formType == EmailPasswordSignInFormType.register) {
      return EmailPasswordSignInStrings.password8CharactersLabel;
    }
    return EmailPasswordSignInStrings.passwordLabel;
  }

  // Getters
  String? get primaryButtonText {
    return <EmailPasswordSignInFormType, String>{
      EmailPasswordSignInFormType.register:
          EmailPasswordSignInStrings.createAnAccount,
      EmailPasswordSignInFormType.signIn: EmailPasswordSignInStrings.signIn,
      EmailPasswordSignInFormType.forgotPassword:
          EmailPasswordSignInStrings.sendResetLink,
    }[formType];
  }

  String? get secondaryButtonText {
    return <EmailPasswordSignInFormType, String>{
      EmailPasswordSignInFormType.register:
          EmailPasswordSignInStrings.haveAnAccount,
      EmailPasswordSignInFormType.signIn:
          EmailPasswordSignInStrings.needAnAccount,
      EmailPasswordSignInFormType.forgotPassword:
          EmailPasswordSignInStrings.backToSignIn,
    }[formType];
  }

  EmailPasswordSignInFormType? get secondaryActionFormType {
    return <EmailPasswordSignInFormType, EmailPasswordSignInFormType>{
      EmailPasswordSignInFormType.register: EmailPasswordSignInFormType.signIn,
      EmailPasswordSignInFormType.signIn: EmailPasswordSignInFormType.register,
      EmailPasswordSignInFormType.forgotPassword:
          EmailPasswordSignInFormType.signIn,
    }[formType];
  }

  String? get errorAlertTitle {
    return <EmailPasswordSignInFormType, String>{
      EmailPasswordSignInFormType.register:
          EmailPasswordSignInStrings.registrationFailed,
      EmailPasswordSignInFormType.signIn:
          EmailPasswordSignInStrings.signInFailed,
      EmailPasswordSignInFormType.forgotPassword:
          EmailPasswordSignInStrings.passwordResetFailed,
    }[formType];
  }

  String? get title {
    return <EmailPasswordSignInFormType, String>{
      EmailPasswordSignInFormType.register: EmailPasswordSignInStrings.register,
      EmailPasswordSignInFormType.signIn: EmailPasswordSignInStrings.signIn,
      EmailPasswordSignInFormType.forgotPassword:
          EmailPasswordSignInStrings.forgotPassword,
    }[formType];
  }

  bool get canSubmitEmail {
    return emailSubmitValidator.isValid(email);
  }

  bool get canSubmitFirstName {
    if (formType == EmailPasswordSignInFormType.register) {
      return firstNameSubmitValidator.isValid(firstName);
    } else {
      return true;
    }
  }

  bool get canSubmitLastName {
    if (formType == EmailPasswordSignInFormType.register) {
      return lastNameSubmitValidator.isValid(lastName);
    } else {
      return true;
    }
  }

  bool get canSubmitPassword {
    if (formType == EmailPasswordSignInFormType.register) {
      return passwordRegisterSubmitValidator.isValid(password);
    }
    return passwordSignInSubmitValidator.isValid(password);
  }

  bool get canSubmit {
    final bool canSubmitFields =
        formType == EmailPasswordSignInFormType.forgotPassword
            ? canSubmitEmail
            : canSubmitEmail &&
                canSubmitPassword &&
                canSubmitFirstName &&
                canSubmitLastName;
    return canSubmitFields && !isLoading;
  }

  String? get emailErrorText {
    final bool showErrorText = submitted && !canSubmitEmail;
    final String errorText = email.isEmpty
        ? EmailPasswordSignInStrings.invalidEmailEmpty
        : EmailPasswordSignInStrings.invalidEmailErrorText;
    return showErrorText ? errorText : null;
  }

  String? get passwordErrorText {
    final bool showErrorText = submitted && !canSubmitPassword;
    final String errorText = password.isEmpty
        ? EmailPasswordSignInStrings.invalidPasswordEmpty
        : EmailPasswordSignInStrings.invalidPasswordTooShort;
    return showErrorText ? errorText : null;
  }

  String? get firstNameErrorText {
    final bool showErrorText = submitted && !canSubmitFirstName;
    final String errorText = firstName.isEmpty
        ? EmailPasswordSignInStrings.invalidFirstNameEmpty
        : EmailPasswordSignInStrings.invalidFirstNameErrorText;
    return showErrorText ? errorText : null;
  }

  String? get lastNameErrorText {
    final bool showErrorText = submitted && !canSubmitLastName;
    final String errorText = lastName.isEmpty
        ? EmailPasswordSignInStrings.invalidLastNameEmpty
        : EmailPasswordSignInStrings.invalidLastNameErrorText;
    return showErrorText ? errorText : null;
  }

  @override
  String toString() {
    return 'email: $email, password: $password, formType: $formType, isLoading: $isLoading, submitted: $submitted';
  }
}
