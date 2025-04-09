import 'package:ascca_app/shared/constants/app_texts.dart';
import 'package:flutter/material.dart';

import 'create_event_formfield.dart';

class CreateEventStreet extends StatelessWidget {
  final TextEditingController eventStreetController;

  const CreateEventStreet({super.key, required this.eventStreetController});

  @override
  Widget build(BuildContext context) {
    return CreateEventFormfield(
      labelText: AppTexts.eventStreet,
      controller: eventStreetController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Zəhmət olmasa, tədbirin küçəsini daxil edin';
        }
        return null;
      },
    );
  }
}
