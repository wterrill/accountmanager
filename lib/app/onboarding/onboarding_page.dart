import 'package:accountmanager/app/onboarding/rive_animation.dart';
import 'package:accountmanager/constants/keys.dart';
import 'package:accountmanager/provider_defs/provider_defs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:accountmanager/packages/custom_buttons/custom_buttons.dart';

class OnboardingPage extends StatelessWidget {
  Future<void> onGetStarted(BuildContext context) async {
    final onboardingViewModel =
        context.read(onboardingViewModelProvider.notifier);
    await onboardingViewModel.completeOnboarding();
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
              'MXOtech Account Manager.\nManage Well, Manage Quickly.',
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
            const Flexible(
              child: FractionallySizedBox(
                widthFactor: 0.4,
                heightFactor: 0.9,
                // child: PlatformSvg.asset('assets/time-tracking.svg')
                child: RiveAnimation(),
                //Image.network('/assets/time-tracking.svg')
                // child: SvgPicture.asset('assets/images/time-tracking.svg',
                //     semanticsLabel: 'Time tracking logo'),
              ),
            ),
            CustomRaisedButton(
              key: const Key(Keys.getStarted),
              onPressed: () => onGetStarted(context),
              color: Colors.indigo,
              borderRadius: 30,
              child: Text(
                'Get Started',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
