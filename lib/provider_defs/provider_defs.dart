import 'package:accountmanager/app/onboarding/onboarding_view_model.dart';
import 'package:accountmanager/services/shared_preferences_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final onboardingViewModelProvider =
    StateNotifierProvider<OnboardingViewModel, bool>((ref) {
  final sharedPreferencesService = ref.watch(sharedPreferencesServiceProvider);
  final OnboardingViewModel view =
      OnboardingViewModel(sharedPreferencesService);
  return view;
});

final sharedPreferencesServiceProvider =
    Provider<SharedPreferencesService>((ref) => throw UnimplementedError());
