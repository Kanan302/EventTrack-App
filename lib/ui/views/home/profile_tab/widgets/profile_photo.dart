import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../shared/theme/app_colors.dart';

class ProfilePhoto extends StatelessWidget {
  final String? profilePictureUrl;

  const ProfilePhoto({super.key, this.profilePictureUrl});

  @override
  Widget build(BuildContext context) {
    final bool hasImage =
        profilePictureUrl != null && profilePictureUrl!.isNotEmpty;

    return hasImage
        ? ClipOval(
          child: CachedNetworkImage(
            imageUrl: profilePictureUrl!,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        )
        : CircleAvatar(
          backgroundColor: AppColors.lavenderBlue,
          radius: 40,
          child: Icon(Icons.person, size: 40, color: AppColors.white),
        );
  }
}
