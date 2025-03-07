import 'package:ascca_app/shared/constants/app_texts.dart';
import 'package:flutter/material.dart';

import 'create_event_formfield.dart';

class CreateEventName extends StatelessWidget {
  final TextEditingController? eventNameController;

  const CreateEventName({super.key, this.eventNameController});

  @override
  Widget build(BuildContext context) {
    return CreateEventFormfield(
      labelText: AppTexts.eventName,
      controller: eventNameController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Zəhmət olmasa, tədbirin adını daxil edin';
        }
        return null;
      },
    );
  }
}
