import 'package:ascca_app/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class OrganizerPhoto extends StatelessWidget {
  const OrganizerPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.lavenderBlue,
      radius: 40,
      // backgroundImage: _image != null ? FileImage(_image!) : null,
      child: Icon(Icons.person, size: 40, color: AppColors.white),
    );
  }
}
