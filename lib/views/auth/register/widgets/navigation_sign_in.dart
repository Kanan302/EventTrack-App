import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_routes.dart';
import '../../../../core/utils/app_texts.dart';

class NavigationSignIn extends StatelessWidget {
  const NavigationSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(AppTexts.alreadyHaveAccount),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () => context.push(AppRoutes.login.path),
          child: const Text(
            AppTexts.signIn,
            style: TextStyle(color: AppColors.lavenderBlue),
          ),
        ),
      ],
    );
  }
}
