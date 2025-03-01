import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      backgroundColor: AppColors.lavenderBlue,
      radius: 40,
      child: Icon(Icons.person, size: 40, color: AppColors.white),
    );
  }
}
