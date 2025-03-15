import 'package:ascca_app/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileName extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController aboutMeController;
  final ValueNotifier<bool> isEditingNotifier;

  const ProfileName({
    super.key,
    required this.nameController,
    required this.aboutMeController,
    required this.isEditingNotifier,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        ValueListenableBuilder(
          valueListenable: isEditingNotifier,
          builder: (context, isEditing, child) {
            return isEditing
                ? SizedBox(
                  width: width * 0.8,
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Adınız',
                      hintStyle: TextStyle(color: AppColors.softGray),
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                : Text(
                  nameController.text,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                );
          },
        ),
        ValueListenableBuilder(
          valueListenable: isEditingNotifier,
          builder: (context, isEditing, child) {
            return isEditing
                ? SizedBox(
                  width: width * 0.5,
                  child: TextField(
                    controller: aboutMeController,
                    decoration: InputDecoration(
                      hintText: 'Haqqınızda',
                      hintStyle: TextStyle(color: AppColors.softGray),
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                : Text(
                  aboutMeController.text,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                );
          },
        ),
      ],
    );
  }
}
