import 'package:ascca_app/shared/constants/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'create_event_formfield.dart';

class CreateEventDate extends StatelessWidget {
  final TextEditingController? eventStartDateTimeController;
  final TextEditingController? eventEndDateTimeController;

  const CreateEventDate({
    super.key,
    this.eventStartDateTimeController,
    this.eventEndDateTimeController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CreateEventFormfield(
            labelText: AppTexts.eventStartDate,
            controller: eventStartDateTimeController,
            onTap: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  final DateTime fullDateTime = DateTime(
                    pickedDate.year,
                    pickedDate.month,
                    pickedDate.day,
                    pickedTime.hour,
                    pickedTime.minute,
                  );
                  final String formattedDateTime = DateFormat(
                    'dd-MM-yyyy HH:mm',
                  ).format(fullDateTime);
                  eventStartDateTimeController?.text = formattedDateTime;

                  // context.read<CreateEventProvider>().startDate = fullDateTime;
                }
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Zəhmət olmasa, başlanğıc tarixini seçin';
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: CreateEventFormfield(
            labelText: AppTexts.eventEndDate,
            controller: eventEndDateTimeController,
            onTap: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  final DateTime fullDateTime = DateTime(
                    pickedDate.year,
                    pickedDate.month,
                    pickedDate.day,
                    pickedTime.hour,
                    pickedTime.minute,
                  );
                  final String formattedDateTime = DateFormat(
                    'dd-MM-yyyy HH:mm',
                  ).format(fullDateTime);
                  eventEndDateTimeController?.text = formattedDateTime;

                  // context.read<CreateEventProvider>().endDate = fullDateTime;
                }
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Zəhmət olmasa, bitiş tarixini seçin';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
