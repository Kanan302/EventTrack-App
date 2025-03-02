import 'package:flutter/material.dart';

import '../../../../core/utils/app_routes.dart';
import '../../services/onboarding_notifier.dart';
import '../widgets/onboarding_section.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final OnboardingNotifier _onboardingNotifier;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _onboardingNotifier = OnboardingNotifier();
    _pageController = PageController(initialPage: _onboardingNotifier.value);
  }

  @override
  void dispose() {
    _onboardingNotifier.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder<int>(
          valueListenable: _onboardingNotifier,
          builder: (context, currentPage, child) {
            return Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: _onboardingNotifier.updateCurrentPage,
                    itemCount: _onboardingNotifier.onboardingImages.length,
                    itemBuilder: (context, index) {
                      return OnboardingSection(
                        imagePath: _onboardingNotifier.onboardingImages[index],
                        title: _onboardingNotifier.titles[index],
                        goToNextPage:
                            () => _onboardingNotifier.goToNextPage(
                              context,
                              AppRoutes.login.path,
                              _pageController,
                            ),
                        skipOnboarding:
                            () => _onboardingNotifier.skipOnboarding(
                              context,
                              AppRoutes.login.path,
                            ),
                        currentPage: index,
                        totalPages: _onboardingNotifier.onboardingImages.length,
                        onDotPressed: (dotIndex) {
                          _pageController.animateToPage(
                            dotIndex,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                          _onboardingNotifier.updateCurrentPage(dotIndex);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
