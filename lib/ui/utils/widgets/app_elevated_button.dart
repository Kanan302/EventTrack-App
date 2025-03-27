import 'package:ascca_app/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color buttonColor;
  final String text;
  final Color textColor;
  final Widget? icon;
  final Color? borderColor;
  final bool isLoading;

  const AppElevatedButton({
    super.key,
    required this.onPressed,
    required this.buttonColor,
    required this.text,
    required this.textColor,
    this.icon,
    this.borderColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        disabledBackgroundColor: buttonColor,
        minimumSize: const Size(260, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        side: BorderSide(color: borderColor ?? buttonColor, width: 2),
      ),
      child:
          isLoading
              ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(color: AppColors.white),
              )
              : icon == null
              ? Text(text, style: TextStyle(color: textColor, fontSize: 16))
              : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  icon!,
                  const SizedBox(width: 15),
                  Text(text, style: TextStyle(color: textColor, fontSize: 16)),
                ],
              ),
    );
  }
}
