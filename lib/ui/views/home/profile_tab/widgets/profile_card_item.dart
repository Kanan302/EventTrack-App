import 'package:ascca_app/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

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
  final ValueNotifier<bool>? darkModeNotifier;

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
    this.darkModeNotifier,
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
        leading: Icon(leadingIcon, color: leadingIconColor, size: 27),
        trailing:
            isDarkMode && darkModeNotifier != null
                ? ValueListenableBuilder<bool>(
                  valueListenable: darkModeNotifier!,
                  builder: (context, isDark, child) {
                    return Switch(
                      value: isDark,
                      activeColor: AppColors.lavenderBlue,
                      onChanged: (value) {
                        darkModeNotifier!.value = value;
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
