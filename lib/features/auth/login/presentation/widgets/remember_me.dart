
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_texts.dart';
import '../../services/toggle_provider.dart';

class RememberMe extends StatelessWidget {
  const RememberMe({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Toggle>(
      builder: (context, rememberProvider, child) {
        return Row(
          children: [
            Transform.scale(
              scale: 0.8,
              child: Switch(
                value: rememberProvider.isRememberMe,
                onChanged: (value) {
                  rememberProvider.toggleRemember();
                },
                activeColor: AppColors.lavenderBlue,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            const Text(
              AppTexts.rememberMe,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        );
      },
    );
  }
}