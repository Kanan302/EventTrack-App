import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../../shared/theme/app_colors.dart';

class ProfilePhoto extends StatefulWidget {
  final String? profilePictureUrl;
  const ProfilePhoto({super.key, this.profilePictureUrl});

  @override
  State<ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  final ValueNotifier<bool> _isEditing = ValueNotifier<bool>(false);

  void _toggleEditMode() {
    _isEditing.value = !_isEditing.value;
  }

  @override
  Widget build(BuildContext context) {
    final bool hasImage =
        widget.profilePictureUrl != null &&
        widget.profilePictureUrl!.isNotEmpty;

    return Stack(
      alignment: Alignment.center,
      children: [
        ValueListenableBuilder(
          valueListenable: _isEditing,
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
                  imageUrl: widget.profilePictureUrl!,
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
            onTap: _toggleEditMode,
            child: ValueListenableBuilder(
              valueListenable: _isEditing,
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
      ],
    );
  }
}
