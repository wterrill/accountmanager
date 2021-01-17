import 'package:accountmanager/app/onboarding/onboarding_view_model.dart';
import 'package:accountmanager/services/shared_preferences_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final onboardingViewModelProvider =
    StateNotifierProvider<OnboardingViewModel>((ref) {
  final sharedPreferencesService = ref.watch(sharedPreferencesServiceProvider);
  return OnboardingViewModel(sharedPreferencesService);
});

final sharedPreferencesServiceProvider =
    Provider<SharedPreferencesService>((ref) => throw UnimplementedError());
