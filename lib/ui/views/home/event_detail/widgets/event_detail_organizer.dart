import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../../../shared/constants/app_routes.dart';
import '../../../../../shared/theme/app_colors.dart';
import '../../profile_tab/service/theme_cubit.dart';

class EventDetailOrganizer extends StatelessWidget {
  final String organizerId;
  final String eventOrganizer;
  final String profilePictureUrl;
  final String? aboutOrganizer;

  const EventDetailOrganizer({
    super.key,
    required this.eventOrganizer,
    required this.organizerId,
    required this.profilePictureUrl,
    this.aboutOrganizer,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final bool isDarkMode = themeMode == ThemeMode.dark;
        return ListTile(
          onTap: () {
            context.push(
              AppRoutes.organizer.path,
              extra: int.parse(organizerId),
            );
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
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child:
                  profilePictureUrl.isNotEmpty
                      ? CachedNetworkImage(
                        imageUrl: profilePictureUrl,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      )
                      : Icon(
                        Icons.person,
                        size: 30,
                        color: AppColors.lavenderBlue,
                      ),
            ),
          ),
          title: Text(
            eventOrganizer,
            style: TextStyle(
              fontSize: 16,
              color: isDarkMode ? AppColors.white : AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            (aboutOrganizer == null || aboutOrganizer!.isEmpty)
                ? AppLocalizations.of(context).organizer
                : aboutOrganizer ?? '',
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
