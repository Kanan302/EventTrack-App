import 'package:ascca_app/shared/theme/app_colors.dart';
import 'package:ascca_app/ui/modules/home/profile_tab/service/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventDetailLocation extends StatelessWidget {
  final String eventCity;
  final String eventStreet;

  const EventDetailLocation({
    super.key,
    required this.eventCity,
    required this.eventStreet,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.paleSkyBlue,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Icon(
            Icons.location_on,
            color: AppColors.lavenderBlue,
            size: 32,
          ),
        ),
        const SizedBox(width: 12),
        BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            final bool isDarkMode = themeMode == ThemeMode.dark;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eventStreet,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDarkMode ? AppColors.white : AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 1.5),
                Text(
                  eventCity,
                  style: TextStyle(
                    fontSize: 14,
                    color:
                        isDarkMode ? AppColors.white70 : AppColors.graphiteGray,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
