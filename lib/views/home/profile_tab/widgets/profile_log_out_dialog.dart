import 'package:ascca_app/core/theme/app_colors.dart';
import 'package:ascca_app/core/utils/app_texts.dart';
import 'package:ascca_app/widgets/app_elevated_button.dart';
import 'package:flutter/material.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const LogoutDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text(
        "Çıxış",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: const Text(
        "Çıxış etmək istədiyinizdən əminsiniz?",
        style: TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        Row(
          children: [
            Expanded(
              child: AppElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                buttonColor: AppColors.white,
                text: "Ləğv et",
                textColor: AppColors.lavenderBlue,
                borderColor: AppColors.lavenderBlue,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: AppElevatedButton(
                onPressed: onConfirm,
                buttonColor: AppColors.red,
                text: AppTexts.logOut,
                textColor: AppColors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
