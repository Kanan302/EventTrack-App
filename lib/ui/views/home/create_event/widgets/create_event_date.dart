import 'package:ascca_app/ui/views/home/create_event/service/create_event_date_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  Future<void> _pickDateTime(
    BuildContext context,
    TextEditingController controller,
    bool isStart,
  ) async {
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
          'dd.MM.yyyy HH:mm',
        ).format(fullDateTime);
        controller.text = formattedDateTime;

        if (isStart) {
          dateService.setStartDate(fullDateTime);
        } else {
          dateService.setEndDate(fullDateTime);
        }
      }
    }
  }

  String? validateDateTimeFormat(String? value) {
    if (value == null || value.isEmpty) {
      return 'Zəhmət olmasa, tarixi seçin';
    }

    try {
      DateFormat("dd.MM.yyyy HH:mm").parseStrict(value);
    } catch (e) {
      return 'Tarixi düzgün formatda daxil edin (dd.MM.yyyy HH:mm)';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CreateEventFormfield(
            labelText: 'Başlanğıc Tarixi',
            controller: eventStartDateTimeController,
            onTap:
                () =>
                    _pickDateTime(context, eventStartDateTimeController, true),
            validator: validateDateTimeFormat,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: CreateEventFormfield(
            labelText: 'Bitiş Tarixi',
            controller: eventEndDateTimeController,
            onTap:
                () => _pickDateTime(context, eventEndDateTimeController, false),
            validator: validateDateTimeFormat,
          ),
        ),
      ],
    );
  }
}
