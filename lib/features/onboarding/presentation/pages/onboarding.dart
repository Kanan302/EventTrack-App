
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_routes.dart';
import '../../services/onboarding_provider.dart';
import '../widgets/onboarding_section.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingProvider(),
      child: Scaffold(
        body: SafeArea(
          child: Consumer<OnboardingProvider>(
            builder: (context, onboardingProvider, child) {
              final pageController =
                  PageController(initialPage: onboardingProvider.currentPage);

              return Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: pageController,
                      onPageChanged: (index) {
                        onboardingProvider.updateCurrentPage(index);
                      },
                      itemCount: onboardingProvider.onboardingImages.length,
                      itemBuilder: (context, index) {
                        return OnboardingSection(
                          imagePath: onboardingProvider.onboardingImages[index],
                          title: onboardingProvider.titles[index],
                          goToNextPage: () => onboardingProvider.goToNextPage(
                            context,
                            AppRoutes.login.path,
                            pageController,
                          ),
                          skipOnboarding: () =>
                              onboardingProvider.skipOnboarding(
                            context,
                            AppRoutes.login.path,
                          ),
                          currentPage: index,
                          totalPages:
                              onboardingProvider.onboardingImages.length,
                          onDotPressed: (dotIndex) {
                            pageController.animateToPage(
                              dotIndex,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                            onboardingProvider.updateCurrentPage(dotIndex);
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
      ),
    );
  }
}