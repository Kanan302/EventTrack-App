import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../shared/theme/app_colors.dart';
import '../../../../../shared/constants/app_routes.dart';
import '../../../../../shared/constants/app_texts.dart';

class NavigationSignUp extends StatelessWidget {
  const NavigationSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(AppTexts.dontHaveAccount),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () => context.push(AppRoutes.register.path),
          child: const Text(
            AppTexts.signUp,
            style: TextStyle(color: AppColors.lavenderBlue),
          ),
        ),
      ],
    );
  }
}
