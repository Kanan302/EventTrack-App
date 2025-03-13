import 'package:ascca_app/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileName extends StatefulWidget {
  final String fullName;
  final String aboutMe;
  final ValueNotifier<bool> isEditingNotifier;

  const ProfileName({
    super.key,
    required this.fullName,
    required this.aboutMe,
    required this.isEditingNotifier,
  });

  @override
  State<ProfileName> createState() => _ProfileNameState();
}

class _ProfileNameState extends State<ProfileName> {
  late TextEditingController _nameController;
  late TextEditingController _aboutMeController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.fullName);
    _aboutMeController = TextEditingController(text: widget.aboutMe);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        ValueListenableBuilder(
          valueListenable: widget.isEditingNotifier,
          builder: (context, isEditing, child) {
            return isEditing
                ? SizedBox(
                  width: width * 0.8,
                  child: TextField(
                    controller: _nameController,
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
                  _nameController.text,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                );
          },
        ),
        ValueListenableBuilder(
          valueListenable: widget.isEditingNotifier,
          builder: (context, isEditing, child) {
            return isEditing
                ? SizedBox(
                  width: width * 0.5,
                  child: TextField(
                    controller: _aboutMeController,
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
                  _aboutMeController.text,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _aboutMeController.dispose();
    super.dispose();
  }
}
