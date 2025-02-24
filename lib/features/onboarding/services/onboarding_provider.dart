import 'package:ascca_app/core/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_texts.dart';

class OnboardingProvider with ChangeNotifier {
  int _currentPage = 0;

  int get currentPage => _currentPage;

  List<String> onboardingImages = [
    AppImages.onboarding1.path,
    AppImages.onboarding2.path,
    AppImages.onboarding3.path,
  ];

  List<String> titles = [
    AppTexts.firstOnboardingTitle,
    AppTexts.secondOnboardingTitle,
    AppTexts.thirdOnboardingTitle,
  ];

  void updateCurrentPage(int index) {
    _currentPage = index;
    notifyListeners();
  }

  void goToNextPage(
    BuildContext context,
    String route,
    PageController pageController,
  ) {
    if (_currentPage < onboardingImages.length - 1) {
      _currentPage++;
      pageController.animateToPage(
        _currentPage,
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
