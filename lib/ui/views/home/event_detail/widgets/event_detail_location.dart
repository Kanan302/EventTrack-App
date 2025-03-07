import 'package:ascca_app/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class EventDetailLocation extends StatelessWidget {
  final String eventLocation;
  const EventDetailLocation({super.key, required this.eventLocation});

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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              eventLocation.toString().split(',')[0],
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 1.5),
            Text(
              eventLocation.toString().split(',').sublist(1).join(',').trim(),
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.graphiteGray,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
