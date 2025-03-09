import 'package:ascca_app/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class OrganizerPhoto extends StatelessWidget {
  final String? profilePictureUrl;

  const OrganizerPhoto({super.key, required this.profilePictureUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.lavenderBlue,
      radius: 40,
      foregroundImage:
          profilePictureUrl != null && profilePictureUrl!.isNotEmpty
              ? NetworkImage(profilePictureUrl!)
              : null,
      child:
          profilePictureUrl == null || profilePictureUrl!.isEmpty
              ? Icon(Icons.person, size: 40, color: AppColors.white)
              : null,
    );
  }
}
