import 'package:accountmanager/provider_defs/provider_defs.dart';
import 'package:accountmanager/app/web_view_home/home/home_page.dart';
import 'package:animations/animations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:accountmanager/app/auth_widget.dart';
import 'package:accountmanager/app/onboarding/onboarding_page.dart';
import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/app/sign_in/sign_in_page.dart';
import 'package:accountmanager/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:accountmanager/services/shared_preferences_service.dart';

String filename = 'main.dart:';

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
    DateTime lastBuild;
    final firebaseAuth = context.read(firebaseAuthProvider);
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android:
                FadeThroughPageTransitionsBuilder(fillColor: Colors.red),
            TargetPlatform.iOS:
                FadeThroughPageTransitionsBuilder(fillColor: Colors.red),
          },
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: AuthWidget(
        nonSignedInBuilder: (_) {
          return Consumer(
            builder: (context, watch, _) {
              final sharedPreferencesService =
                  watch(sharedPreferencesServiceProvider);
              lastBuild = sharedPreferencesService.getLastDateTime();
              print(DateTime.now());
              print(lastBuild);
              print(lastBuild?.add(const Duration(minutes: 60)));
              DateTime now = DateTime.now();
              DateTime last = lastBuild;
              DateTime limit = lastBuild.add(const Duration(seconds: 60));
              if (now.isAfter(limit) ?? false) {
                deleteOnboarding(context);
                sharedPreferencesService.setLastDateTime(DateTime.now());
              }
              final didCompleteOnboarding =
                  watch(onboardingViewModelProvider.state);
              return didCompleteOnboarding ? SignInPage() : OnboardingPage();
            },
          );
        },
        signedInBuilder: (_) {
          // return HomePage();
          return WebViewHomePage();
        },
      ),
      onGenerateRoute: (settings) {
        return AppRouter.onGenerateRoute(settings, firebaseAuth);
      },
    );
  }
}

Future<void> deleteOnboarding(BuildContext context) async {
  final onboardingViewModel = context.read(onboardingViewModelProvider);
  await onboardingViewModel.deleteOnboarding();
}
