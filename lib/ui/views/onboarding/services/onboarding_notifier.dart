import 'package:ascca_app/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/constants/app_images.dart';

class OnboardingNotifier extends ValueNotifier<int> {
  OnboardingNotifier() : super(0);

  final List<String> onboardingImages = [
    AppImages.onboarding1.path,
    AppImages.onboarding2.path,
    AppImages.onboarding3.path,
  ];

  List<String> titles(BuildContext context) => [
    AppLocalizations.of(context).discoverUpcomingNearbyEvents,
    AppLocalizations.of(context).followEventsWithCalendar,
    AppLocalizations.of(context).discoverNearbyEventsEasily,
  ];

  List<String> subTitles(BuildContext context) => [
    AppLocalizations.of(context).findInterestingEvents,
    AppLocalizations.of(context).planWithGoEvent,
    AppLocalizations.of(context).findEventsWithMap,
  ];

  void updateCurrentPage(int index) {
    value = index;
  }

  void goToNextPage(
    BuildContext context,
    String route,
    PageController pageController,
  ) {
    if (value < onboardingImages.length - 1) {
      value++;
      pageController.animateToPage(
        value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.go(route);
    }
  }

  void skipOnboarding(BuildContext context, String route) {
    context.go(route);
  }
}
