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

import 'package:flutter/cupertino.dart';
import 'package:accountmanager/models/job.dart';

class CupertinoTabViewRoutes {
  static const jobEntriesPage = '/job-entries-page';
}

class CupertinoTabViewRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CupertinoTabViewRoutes.jobEntriesPage:
        final job = settings.arguments as Job;
        return CupertinoPageRoute(
          builder: (_) =>
              Text('deleted on shift to web code'), //JobEntriesPage(job: job),
          settings: settings,
          fullscreenDialog: false,
        );
    }
    return null;
  }
}
