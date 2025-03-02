import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color buttonColor;
  final String text;
  final Color textColor;
  final Widget? icon;
  final Color? borderColor;

  const AppElevatedButton({
    super.key,
    required this.onPressed,
    required this.buttonColor,
    required this.text,
    required this.textColor,
    this.icon,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        minimumSize: const Size(260, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        side: BorderSide(
          color: borderColor ?? buttonColor,
          width: 2,
        ),
      ),
      child: icon == null
          ? Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon!,
                const SizedBox(width: 15),
                Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
    );
  }
}