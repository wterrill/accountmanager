// ignore_for_file: file_names
// ignore_for_file: prefer_asserts_with_message
// ignore_for_file: avoid_types_on_closure_parameters
// ignore_for_file: avoid_positional_boolean_parameters
// ignore_for_file: avoid_returning_null
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: parameter_assignments
// ignore_for_file: join_return_with_assignment
// ignore_for_file: prefer_const_constructors
// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: prefer_final_locals
// ignore_for_file: unused_local_variable

import 'package:accountmanager/models/assigned_tbr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:accountmanager/models/entry.dart';
import 'package:accountmanager/models/job.dart';
import 'package:accountmanager/packages/email_password_sign_in_ui/test/email_password_sign_in_page.dart';

class AppRoutes {
  static const emailPasswordSignInPage = '/email-password-sign-in-page';
  static const editJobPage = '/edit-job-page';
  static const entryPage = '/entry-page';
  static const tbrPage = '/tbr-page';
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(
      RouteSettings settings, FirebaseAuth firebaseAuth) {
    final args = settings.arguments;
    print('args=$args');
    switch (settings.name) {
      case AppRoutes.emailPasswordSignInPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => EmailPasswordSignInPage.withFirebaseAuth(firebaseAuth,
              onSignedIn: args),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.editJobPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) =>
              Text('deleted on shift to web code'), // EditJobPage(job: args),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.entryPage:
        final mapArgs = args as Map<String, dynamic>;
        final job = mapArgs['job'] as Job;
        final entry = mapArgs['entry'] as Entry;
        return MaterialPageRoute<dynamic>(
          builder: (_) => Text(
              'deleted on shift to web code'), //EntryPage(job: job, entry: entry),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.tbrPage:
        final mapArgs = args as Map<String, dynamic>;
        final data = mapArgs['data'] as AssignedTBR;
        final entry = mapArgs['entry'] as Entry;
        return MaterialPageRoute<dynamic>(
          builder: (_) => Text('deleted on shift to web code'),

          ///TBREntry(data: data),
          settings: settings,
          fullscreenDialog: true,
        );

      default:
        // TODO: Throw
        return null;
    }
  }
}
