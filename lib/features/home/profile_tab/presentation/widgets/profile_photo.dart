import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';

class ProfilePhoto extends StatefulWidget {
  const ProfilePhoto({super.key});

  @override
  State<ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  final ValueNotifier<bool> _isEditing = ValueNotifier<bool>(false);
  File? _image;

  // Future<void> _pickImage() async {
  //   final pickedFile = await ImagePicker().pickImage(
  //     source: ImageSource.gallery,
  //   );

  //   if (pickedFile != null) {
  //     setState(() {
  //       _image = File(pickedFile.path);
  //       _isEditing = false;
  //     });
  //   }
  // }

  void _toggleEditMode() {
    _isEditing.value = !_isEditing.value;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ValueListenableBuilder(
          valueListenable: _isEditing,
          builder: (context, isEditing, child) {
            return CircleAvatar(
              backgroundColor: AppColors.lavenderBlue,
              radius: 40,
              backgroundImage: _image != null ? FileImage(_image!) : null,
              child:
                  _image == null
                      ? Icon(
                        isEditing ? Icons.upload : Icons.person,
                        size: 40,
                        color: AppColors.white,
                      )
                      : null,
            );
          },
        ),
        Positioned.fill(
          child: ValueListenableBuilder(
            valueListenable: _isEditing,
            builder: (context, isEditing, child) {
              return isEditing
                  ? Material(
                    color: AppColors.transparent,
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(40),
                    ),
                  )
                  : SizedBox.shrink();
            },
          ),
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
