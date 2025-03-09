import 'package:ascca_app/shared/constants/app_texts.dart';
import 'package:flutter/material.dart';

import 'create_event_formfield.dart';

class CreateEventLocation extends StatelessWidget {
  final TextEditingController eventLocationController;

  const CreateEventLocation({super.key, required this.eventLocationController});

  @override
  Widget build(BuildContext context) {
    return CreateEventFormfield(
      labelText: AppTexts.eventLocation,
      controller: eventLocationController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Zəhmət olmasa, tədbirin yerini daxil edin';
        }
        return null;
      },
    );
  }
}
