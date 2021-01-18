//import 'package:auth_widget_builder/auth_widget_builder.dart';
import 'package:accountmanager/app/home/overview/overview_page.dart';
import 'package:accountmanager/provider_defs/provider_defs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:accountmanager/app/auth_widget.dart';
import 'package:accountmanager/app/home/home_page.dart';
import 'package:accountmanager/app/onboarding/onboarding_page.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/app/sign_in/sign_in_page.dart';
import 'package:accountmanager/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:accountmanager/services/shared_preferences_service.dart';

import 'app/home/account/account_page.dart';

String filename = 'main.dart:';

///////////

final greetingProvider = Provider((ref) => 'Hello');
final incrementProvider = ChangeNotifierProvider((ref) => IncrementNotifier());
//////////

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(ProviderScope(
    overrides: [
      // override the behavior  to provide a fake
      // implementation for test purposes.
      sharedPreferencesServiceProvider.overrideWithValue(
        SharedPreferencesService(sharedPreferences),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseAuth = context.read(firebaseAuthProvider);
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.indigo),
      debugShowCheckedModeBanner: false,
      home: AuthWidget(
        nonSignedInBuilder: (_) {
          return Consumer(
            builder: (context, watch, _) {
              final didCompleteOnboarding =
                  watch(onboardingViewModelProvider.state);
              return didCompleteOnboarding ? SignInPage() : OnboardingPage();
            },
          );
        },
        signedInBuilder: (_) {
          return HomePage();
        },
      ),
      onGenerateRoute: (settings) {
        return AppRouter.onGenerateRoute(settings, firebaseAuth);
      },
    );
  }
}
