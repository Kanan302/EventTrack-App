import 'package:ascca_app/shared/constants/app_routes.dart';
import 'package:ascca_app/shared/constants/app_texts.dart';
import 'package:ascca_app/shared/theme/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EventDetailOrganizer extends StatelessWidget {
  final String organizerId;
  final String eventOrganizer;
  const EventDetailOrganizer({
    super.key,
    required this.eventOrganizer,
    required this.organizerId,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.push(AppRoutes.organizer.path, extra: int.parse(organizerId));
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
        child: Icon(Icons.person, size: 30, color: AppColors.lavenderBlue),
      ),
      title: Text(
        eventOrganizer,
        style: const TextStyle(
          fontSize: 16,
          color: AppColors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: const Text(
        AppTexts.organizer,
        style: TextStyle(fontSize: 14, color: AppColors.graphiteGray),
      ),
    );
  }
}
