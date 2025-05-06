import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../generated/l10n/app_localizations.dart';
import '../../../../../shared/constants/app_routes.dart';
import '../../../../../shared/theme/app_colors.dart';

class NavigationSignIn extends StatelessWidget {
  const NavigationSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppLocalizations.of(context).alreadyHaveAccount),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () => context.push(AppRoutes.login.path),
          child: Text(
            AppLocalizations.of(context).signIn,
            style: TextStyle(color: AppColors.lavenderBlue),
          ),
        ),
      ],
    );
  }
}
