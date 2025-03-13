import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../../shared/theme/app_colors.dart';

class ProfilePhoto extends StatelessWidget {
  final String? profilePictureUrl;
  final ValueNotifier<bool> isEditingNotifier;

  const ProfilePhoto({
    super.key,
    this.profilePictureUrl,
    required this.isEditingNotifier,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasImage =
        profilePictureUrl != null && profilePictureUrl!.isNotEmpty;

    return Stack(
      alignment: Alignment.center,
      children: [
        ValueListenableBuilder(
          valueListenable: isEditingNotifier,
          builder: (context, isEditing, child) {
            if (isEditing) {
              return CircleAvatar(
                backgroundColor: AppColors.lavenderBlue,
                radius: 40,
                child: IconButton(
                  icon: Icon(Icons.upload, size: 40, color: AppColors.white),
                  onPressed: () {},
                ),
              );
            } else if (hasImage) {
              return ClipOval(
                child: CachedNetworkImage(
                  imageUrl: profilePictureUrl!,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              );
            } else {
              return CircleAvatar(
                backgroundColor: AppColors.lavenderBlue,
                radius: 40,
                child: Icon(Icons.person, size: 40, color: AppColors.white),
              );
            }
          },
        ),

        Positioned(
          right: 0,
          top: 0,
          child: GestureDetector(
            onTap: () {
              isEditingNotifier.value = !isEditingNotifier.value;
            },
            child: ValueListenableBuilder(
              valueListenable: isEditingNotifier,
              builder: (context, isEditing, child) {
                return Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                    border: Border.all(color: AppColors.softGray, width: 2),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    isEditing ? Icons.close : Icons.edit,
                    size: 16,
                    color: AppColors.black,
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          child: GestureDetector(
            onTap: () {},
            child: ValueListenableBuilder(
              valueListenable: isEditingNotifier,
              builder: (context, isEditing, child) {
                if (isEditing) {
                  return Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white,
                      border: Border.all(color: AppColors.softGray, width: 2),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      Icons.save_as_outlined,
                      size: 18,
                      color: AppColors.black,
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ),
        ),
      ],
    );
  }
}
