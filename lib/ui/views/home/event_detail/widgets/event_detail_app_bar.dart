import 'dart:ui';

import 'package:ascca_app/shared/constants/app_texts.dart';
import 'package:ascca_app/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class EventDetailAppBar extends StatelessWidget {
  final Function()? onTap;
  final IconData? icon;

  const EventDetailAppBar({super.key, this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: Navigator.of(context).pop,
        icon: const Icon(Icons.arrow_back_ios, color: AppColors.white),
      ),
      title: const Text(
        AppTexts.eventDetails,
        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.white),
      ),
      titleSpacing: 0,
      actions: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.all(8),
              color: AppColors.softWhite,
              child: InkWell(
                onTap: onTap,
                child: Icon(icon, color: AppColors.white, size: 25),
              ),
            ),
          ),
        ),
      ],
      centerTitle: false,
    );
  }
}
