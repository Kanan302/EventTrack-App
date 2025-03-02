import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/app_images.dart';
import '../../../core/utils/app_texts.dart';

class OnboardingNotifier extends ValueNotifier<int> {
  OnboardingNotifier() : super(0); 

  final List<String> onboardingImages = [
    AppImages.onboarding1.path,
    AppImages.onboarding2.path,
    AppImages.onboarding3.path,
  ];

  final List<String> titles = [
    AppTexts.firstOnboardingTitle,
    AppTexts.secondOnboardingTitle,
    AppTexts.thirdOnboardingTitle,
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