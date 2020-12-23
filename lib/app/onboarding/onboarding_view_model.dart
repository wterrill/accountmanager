import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:accountmanager/services/shared_preferences_service.dart';
import 'package:state_notifier/state_notifier.dart';

final onboardingViewModelProvider =
    StateNotifierProvider<OnboardingViewModel>((ref) {
  final sharedPreferencesService = ref.watch(sharedPreferencesServiceProvider);
  return OnboardingViewModel(sharedPreferencesService);
});

class OnboardingViewModel extends StateNotifier<bool> {
  OnboardingViewModel(this.sharedPreferencesService)
      : super(sharedPreferencesService.isOnboardingComplete());
  final SharedPreferencesService sharedPreferencesService;

  Future<void> completeOnboarding() async {
    await sharedPreferencesService.setOnboardingComplete();
    state = true;
  }

  Future<void> deleteOnboarding() async {
    await sharedPreferencesService.deleteOnboardingComplete();
    state = true;
  }

  bool get isOnboardingComplete => state;
}
