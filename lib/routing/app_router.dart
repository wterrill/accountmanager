import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:accountmanager/app/home/job_entries/entry_page.dart';
import 'package:accountmanager/app/home/jobs/edit_job_page.dart';
import 'package:accountmanager/app/home/models/entry.dart';
import 'package:accountmanager/app/home/models/job.dart';
import 'package:accountmanager/packages/email_password_sign_in_ui/test/email_password_sign_in_page.dart';

class AppRoutes {
  static const emailPasswordSignInPage = '/email-password-sign-in-page';
  static const editJobPage = '/edit-job-page';
  static const entryPage = '/entry-page';
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
          builder: (_) => EditJobPage(job: args),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.entryPage:
        final mapArgs = args as Map<String, dynamic>;
        final job = mapArgs['job'] as Job;
        final entry = mapArgs['entry'] as Entry;
        return MaterialPageRoute<dynamic>(
          builder: (_) => EntryPage(job: job, entry: entry),
          settings: settings,
          fullscreenDialog: true,
        );
      default:
        // TODO: Throw
        return null;
    }
  }
}
