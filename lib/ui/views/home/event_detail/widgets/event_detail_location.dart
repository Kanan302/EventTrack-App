import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../generated/l10n/app_localizations.dart';
import '../../../../../shared/theme/app_colors.dart';
import '../../../../../ui/views/home/profile_tab/service/theme_cubit.dart';
import '../../../../utils/notifications/snackbar.dart';

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
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final isDarkMode = themeMode == ThemeMode.dark;

        return ListTile(
          onTap: () async {
            final query = Uri.encodeComponent(eventStreet);
            final url = Uri.parse(
              'https://www.google.com/maps/search/?api=1&query=$query',
            );

            if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            } else {
              SnackBarService.showSnackBar(
                context,
                AppLocalizations.of(context).googleMapsOpenFailed,
                AppColors.red,
              );
            }
          },
          contentPadding: EdgeInsets.zero,
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.paleSkyBlue,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.location_on,
              color: AppColors.lavenderBlue,
              size: 32,
            ),
          ),
          title: Text(
            eventStreet,
            style: TextStyle(
              fontSize: 16,
              color: isDarkMode ? AppColors.white : AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            eventCity,
            style: TextStyle(
              fontSize: 14,
              color: isDarkMode ? AppColors.white70 : AppColors.graphiteGray,
            ),
          ),
        );
      },
    );
  }
}
