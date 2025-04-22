import 'package:ascca_app/shared/constants/app_texts.dart';
import 'package:ascca_app/ui/utils/validators/validators.dart';
import 'package:flutter/material.dart';

import 'create_event_formfield.dart';

class CreateEventCity extends StatelessWidget {
  final TextEditingController eventCityController;

  const CreateEventCity({super.key, required this.eventCityController});

  @override
  Widget build(BuildContext context) {
    return CreateEventFormField(
      labelText: AppTexts.eventCity,
      controller: eventCityController,
      validator: Validators.writeEventCity,
    );
  }
}
