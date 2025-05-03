import 'package:ascca_app/shared/theme/app_colors.dart';
import 'package:ascca_app/ui/views/home/profile_tab/service/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../service/locale_cubit.dart';

class ProfileCardItem extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final VoidCallback? onTap;
  final Color? leadingIconColor;
  final Color? textColor;
  final bool showTrailing;
  final bool isLanguageSelection;
  final ValueNotifier<String>? selectedLanguage;
  final bool isDarkMode;

  const ProfileCardItem({
    super.key,
    required this.leadingIcon,
    required this.title,
    this.onTap,
    this.leadingIconColor,
    this.textColor,
    this.showTrailing = true,
    this.isLanguageSelection = false,
    this.selectedLanguage,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
        visualDensity: VisualDensity.comfortable,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        onTap: onTap,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: textColor ?? AppColors.lavenderBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Icon(leadingIcon, color: leadingIconColor, size: 26),
        trailing:
            isDarkMode
                ? BlocBuilder<ThemeCubit, ThemeMode>(
                  builder: (context, themeMode) {
                    return Switch(
                      value: themeMode == ThemeMode.dark,
                      activeColor: AppColors.lavenderBlue,
                      onChanged: (value) {
                        context.read<ThemeCubit>().toggleTheme(value);
                      },
                    );
                  },
                )
                : isLanguageSelection && selectedLanguage != null
                ? ValueListenableBuilder<String>(
                  valueListenable: selectedLanguage!,
                  builder: (context, lang, child) {
                    return DropdownButton<String>(
                      value: lang,
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: AppColors.lavenderBlue,
                      ),
                      underline: SizedBox.shrink(),
                      onChanged: (newLang) {
                        if (newLang != null && newLang != lang) {
                          selectedLanguage!.value = newLang;
                          context.read<LocaleCubit>().setLocale(
                            newLang.toLowerCase(),
                          );
                        }
                      },
                      items:
                          ["AZ", "EN", "RU"].map((langCode) {
                            return DropdownMenuItem<String>(
                              value: langCode,
                              child: Text(
                                langCode,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.lavenderBlue,
                                ),
                              ),
                            );
                          }).toList(),
                    );
                  },
                )
                : showTrailing
                ? Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: AppColors.lavenderBlue,
                  size: 25,
                )
                : null,
      ),
    );
  }
}
