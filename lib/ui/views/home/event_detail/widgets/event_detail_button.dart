import 'package:ascca_app/shared/constants/app_texts.dart';
import 'package:ascca_app/shared/theme/app_colors.dart';
import 'package:ascca_app/ui/utils/widgets/app_elevated_button.dart';
import 'package:flutter/material.dart';

class EventDetailButton extends StatelessWidget {
  const EventDetailButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AppElevatedButton(
        onPressed: () {},
        buttonColor: AppColors.lavenderBlue,
        text: AppTexts.buyTicket,
        textColor: AppColors.white,
      ),
    );
  }
}
