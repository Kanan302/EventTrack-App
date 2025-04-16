import 'package:ascca_app/shared/theme/app_colors.dart';
import 'package:ascca_app/ui/views/home/profile_tab/service/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EventDetailDate extends StatelessWidget {
  final String eventStartDate;
  final String eventEndDate;

  const EventDetailDate({
    super.key,
    required this.eventStartDate,
    required this.eventEndDate,
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
            Icons.calendar_month,
            color: AppColors.lavenderBlue,
            size: 32,
          ),
        ),
        const SizedBox(width: 12),
        BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            final bool isDarkMode = themeMode == ThemeMode.dark;

            return RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: DateFormat(
                      'd MMMM, yyyy',
                    ).format(DateTime.parse(eventStartDate)),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? AppColors.white : AppColors.black,
                    ),
                  ),
                  TextSpan(
                    text:
                        '\n${DateFormat('EEEE').format(DateTime.parse(eventStartDate))}, ${DateFormat('h:mma').format(DateTime.parse(eventStartDate))} - ${DateFormat('h:mma').format(DateTime.parse(eventEndDate))}',
                    style: TextStyle(
                      fontSize: 14,
                      color:
                          isDarkMode
                              ? AppColors.white70
                              : AppColors.graphiteGray,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
