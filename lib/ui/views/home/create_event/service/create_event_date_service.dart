import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateEventDateService {
  DateTime? startDate;
  DateTime? endDate;

  // Tarixi `yyyy-MM-dd'T'HH:mm:ss` formatına çevirir
  String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    return formatter.format(dateTime);
  }

  // Başlanğıc tarixini təyin edir
  void setStartDate(DateTime date) {
    startDate = date;
  }

  // Bitmə tarixini təyin edir
  void setEndDate(DateTime date) {
    endDate = date;
  }

  // Formatlanmış başlanğıc tarixini alır
  String? get formattedStartDate =>
      startDate != null ? formatDateTime(startDate!) : null;

  // Formatlanmış bitmə tarixini alır
  String? get formattedEndDate =>
      endDate != null ? formatDateTime(endDate!) : null;
}

Future<void> pickDateTime(
  BuildContext context,
  TextEditingController controller,
  bool isStart,
  CreateEventDateService dateService,
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
