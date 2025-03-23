import 'package:ascca_app/shared/constants/app_texts.dart';
import 'package:flutter/material.dart';

import 'create_event_formfield.dart';

class CreateEventCity extends StatelessWidget {
  final TextEditingController eventCityController;

  const CreateEventCity({super.key, required this.eventCityController});

  @override
  Widget build(BuildContext context) {
    return CreateEventFormfield(
      labelText: AppTexts.eventCity,
      controller: eventCityController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Zəhmət olmasa, tədbirin şəhərini daxil edin';
        }
        return null;
      },
    );
  }
}
