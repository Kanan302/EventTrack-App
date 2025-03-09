import 'package:ascca_app/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class OrganizerName extends StatelessWidget {
  final String name;
  const OrganizerName({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        name,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
      ),
    );
  }
}
