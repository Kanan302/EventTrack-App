import 'package:ascca_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final VoidCallback? onTap;
  final Color? leadingIconColor;
  final Color? textColor;
  final bool showTrailing;

  const ProfileCard({
    super.key,
    required this.leadingIcon,
    required this.title,
    this.onTap,
    this.leadingIconColor,
    this.textColor,
    this.showTrailing = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
        visualDensity: VisualDensity.comfortable,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        onTap: onTap,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: textColor ?? AppColors.lavenderBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Icon(leadingIcon, color: leadingIconColor, size: 27),
        trailing:
            showTrailing
                ? Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: AppColors.lavenderBlue,
                  size: 25,
                )
                : null,
      ),
    );
  }
}
