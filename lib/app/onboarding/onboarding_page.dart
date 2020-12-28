// import 'package:custom_buttons/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:accountmanager/app/onboarding/onboarding_view_model.dart';
import 'package:accountmanager/packages/custom_buttons/custom_buttons.dart';
import 'package:platform_svg/platform_svg.dart';

// import 'package:accountmanager/packages/custom_buttons/lib/custom_buttons.dart';

class OnboardingPage extends StatelessWidget {
  Future<void> onGetStarted(BuildContext context) async {
    final onboardingViewModel = context.read(onboardingViewModelProvider);
    await onboardingViewModel.completeOnboarding();
    // await onboardingViewModel
    //     .deleteOnboarding(); // This is to always show the onboarding screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'MXOTech Account Manager.\nManage Well, Manage Quickly.',
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
            FractionallySizedBox(
                widthFactor: 0.2,
                child: PlatformSvg.asset('assets/time-tracking.svg')
                // child: Image.network('/assets/time-tracking.svg')
                // child: SvgPicture.asset('assets/time-tracking.svg',
                //     semanticsLabel: 'Time tracking logo'),
                ),
            CustomRaisedButton(
              onPressed: () => onGetStarted(context),
              color: Colors.indigo,
              borderRadius: 30,
              child: Text(
                'Get Started',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
