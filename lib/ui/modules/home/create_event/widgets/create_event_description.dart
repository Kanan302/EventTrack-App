import 'package:ascca_app/shared/constants/app_texts.dart';
import 'package:flutter/material.dart';

import 'create_event_formfield.dart';

class CreateEventDescription extends StatelessWidget {
  final TextEditingController eventDescriptionController;

  const CreateEventDescription({super.key, required this.eventDescriptionController});

  @override
  Widget build(BuildContext context) {
    return CreateEventFormfield(
      labelText: AppTexts.eventDescription,
      controller: eventDescriptionController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Zəhmət olmasa, tədbirin təsvirini daxil edin';
        }
        return null;
      },
    );
  }
}
