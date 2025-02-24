
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_texts.dart';

class OnboardingSection extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback? goToNextPage;
  final VoidCallback? skipOnboarding;
  final int currentPage;
  final int totalPages;
  final Function(int)? onDotPressed;

  const OnboardingSection({
    super.key,
    required this.imagePath,
    required this.title,
    this.goToNextPage,
    this.skipOnboarding,
    required this.currentPage,
    required this.totalPages,
    this.onDotPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SvgPicture.asset(
              imagePath,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
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
                  const SizedBox(height: 25),
                  SizedBox(
                    width: 300,
                    child: Text(
                      title,
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
                        onPressed: skipOnboarding,
                        child: const Text(
                          AppTexts.skip,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Row(
                        children: List.generate(totalPages, (index) {
                          return GestureDetector(
                            onTap: () {
                              if (onDotPressed != null) {
                                onDotPressed!(index);
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              width: 8,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentPage == index
                                    ? AppColors.white
                                    : AppColors.softWhite,
                              ),
                            ),
                          );
                        }),
                      ),
                      TextButton(
                        onPressed: goToNextPage,
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
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}