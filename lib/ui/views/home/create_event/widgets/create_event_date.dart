import 'package:ascca_app/ui/views/home/create_event/service/create_event_date_service.dart';
import 'package:flutter/material.dart';
import 'create_event_formfield.dart';

class CreateEventDate extends StatelessWidget {
  final TextEditingController eventStartDateTimeController;
  final TextEditingController eventEndDateTimeController;
  final CreateEventDateService dateService;

  const CreateEventDate({
    super.key,
    required this.eventStartDateTimeController,
    required this.eventEndDateTimeController,
    required this.dateService,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CreateEventFormfield(
            labelText: 'Başlanğıc Tarixi',
            controller: eventStartDateTimeController,
            onTap:
                () => pickDateTime(
                  context,
                  eventStartDateTimeController,
                  true,
                  dateService,
                ),
            validator: validateDateTimeFormat,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: CreateEventFormfield(
            labelText: 'Bitiş Tarixi',
            controller: eventEndDateTimeController,
            onTap:
                () => pickDateTime(
                  context,
                  eventEndDateTimeController,
                  false,
                  dateService,
                ),
            validator: validateDateTimeFormat,
          ),
        ),
      ],
    );
  }
}
