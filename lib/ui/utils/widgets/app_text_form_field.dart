import 'package:ascca_app/ui/views/home/profile_tab/service/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/theme/app_colors.dart';

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
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final bool isDarkMode = themeMode == ThemeMode.dark;
        return TextFormField(
          controller: controller,
          validator: validator,
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixIcon: Icon(prefixIcon, color: AppColors.dustyGray),
            hintText: hintText,
            hintStyle: const TextStyle(color: AppColors.graphiteGray),
            suffixIcon: IconButton(
              icon: Icon(suffixIcon, color: AppColors.dustyGray),
              onPressed: onPressed,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(
                color: isDarkMode ? AppColors.graphiteGray : AppColors.warmGray,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(
                color: isDarkMode ? AppColors.warmGray : AppColors.graphiteGray,
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: AppColors.red),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: AppColors.red),
            ),
          ),
        );
      },
    );
  }
}
