import 'package:flutter/material.dart';

import '../../shared/theme/app_colors.dart';

class AppTextFormField extends StatelessWidget {
  final bool obscureText;
  final String hintText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onPressed;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const AppTextFormField({
    super.key,
    required this.obscureText,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.onPressed,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIcon,
          color: AppColors.dustyGray,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: AppColors.graphiteGray,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            suffixIcon,
            color: AppColors.dustyGray,
          ),
          onPressed: onPressed,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          borderSide: BorderSide(
            color: AppColors.warmGray,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          borderSide: BorderSide(
            color: AppColors.red,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          borderSide: BorderSide(
            color: AppColors.red,
          ),
        ),
      ),
    );
  }
}