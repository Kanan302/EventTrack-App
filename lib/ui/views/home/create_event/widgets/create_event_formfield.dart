import 'package:ascca_app/shared/theme/app_colors.dart';
import 'package:ascca_app/ui/views/home/profile_tab/service/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateEventFormfield extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function()? onTap;

  const CreateEventFormfield({
    super.key,
    required this.labelText,
    this.controller,
    this.validator,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final bool isDarkMode = themeMode == ThemeMode.dark;
        return TextFormField(
          controller: controller,
          validator: validator,
          onTap: onTap,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(
              color: isDarkMode ? AppColors.softGray : AppColors.graphiteGray,
            ),
            border: const OutlineInputBorder(),
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
