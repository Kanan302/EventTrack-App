import 'package:ascca_app/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
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
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: DateFormat(
                  'd MMMM, yyyy',
                ).format(DateTime.parse(eventStartDate)),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              TextSpan(
                text:
                    '\n${DateFormat('EEEE').format(DateTime.parse(eventStartDate))}, ${DateFormat('h:mma').format(DateTime.parse(eventStartDate))} - ${DateFormat('h:mma').format(DateTime.parse(eventEndDate))}',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.graphiteGray,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
