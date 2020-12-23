import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:accountmanager/app/home/jobs/empty_content.dart';
import 'package:accountmanager/app/top_level_providers.dart';

String filename = 'auth_widget.dart: ';

class AuthWidget extends ConsumerWidget {
  const AuthWidget({
    Key key,
    @required this.signedInBuilder,
    @required this.nonSignedInBuilder,
  }) : super(key: key);
  final WidgetBuilder nonSignedInBuilder;
  final WidgetBuilder signedInBuilder;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    print('$filename build method');
    final authStateChanges = watch(authStateChangesProvider);
    print('$filename authStateChange = $authStateChanges');
    return authStateChanges.when(
      data: (user) {
        print('$filename user section reached');
        return _data(context, user);
      },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (_, __) => const Scaffold(
        body: EmptyContent(
          title: 'Something went wrong',
          message: 'Can\'t load data right now.',
        ),
      ),
    );
  }

  Widget _data(BuildContext context, User user) {
    print('$filename _data reached');
    print('user = $user');
    if (user != null) {
      print('$filename return signedInBuilder');
      return signedInBuilder(context);
    }
    print('$filename return nonSignedInBuilder');
    return nonSignedInBuilder(context);
  }
}
