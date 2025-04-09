import 'package:ascca_app/shared/constants/app_texts.dart';
import 'package:ascca_app/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../shared/constants/app_routes.dart';
import '../services/onboarding_notifier.dart';

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
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        bottom: false,
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
                      return SvgPicture.asset(
                        _onboardingNotifier.onboardingImages[index],
                        fit: BoxFit.cover,
                        width: width * 1.06,
                      );
                    },
                  ),
                ),
                Container(
                  height: height * 0.317,
                  decoration: const BoxDecoration(
                    color: AppColors.lavenderBlue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(48),
                      topRight: Radius.circular(48),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // const SizedBox(height: 25),
                      SizedBox(
                        width: 300,
                        child: Text(
                          _onboardingNotifier.titles[_onboardingNotifier.value],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(
                        width: 300,
                        child: Text(
                          AppTexts.loremDescryption,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed:
                                () => _onboardingNotifier.skipOnboarding(
                                  context,
                                  AppRoutes.login.path,
                                ),
                            child: const Text(
                              AppTexts.skip,
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Row(
                            children: List.generate(
                              _onboardingNotifier.onboardingImages.length,
                              (index) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  width: 8,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        currentPage == index
                                            ? AppColors.white
                                            : AppColors.softWhite,
                                  ),
                                );
                              },
                            ),
                          ),
                          TextButton(
                            onPressed:
                                () => _onboardingNotifier.goToNextPage(
                                  context,
                                  AppRoutes.login.path,
                                  _pageController,
                                ),
                            child: const Text(
                              AppTexts.next,
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _onboardingNotifier.dispose();
    _pageController.dispose();
    super.dispose();
  }
}
