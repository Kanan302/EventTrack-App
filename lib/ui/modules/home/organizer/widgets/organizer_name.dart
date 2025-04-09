import 'package:ascca_app/shared/theme/app_colors.dart';
import 'package:ascca_app/ui/modules/home/profile_tab/service/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrganizerName extends StatelessWidget {
  final String name;
  const OrganizerName({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final bool isDarkMode = themeMode == ThemeMode.dark;
        return Align(
          alignment: Alignment.center,
          child: Text(
            name,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? AppColors.white : AppColors.black,
            ),
          ),
        );
      },
    );
  }
}
