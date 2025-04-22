import 'package:ascca_app/shared/constants/app_texts.dart';
import 'package:ascca_app/ui/utils/validators/validators.dart';
import 'package:flutter/material.dart';

import 'create_event_formfield.dart';

class CreateEventName extends StatelessWidget {
  final TextEditingController eventNameController;

  const CreateEventName({super.key, required this.eventNameController});

  @override
  Widget build(BuildContext context) {
    return CreateEventFormField(
      labelText: AppTexts.eventName,
      controller: eventNameController,
      validator: Validators.writeEventName,
    );
  }
}
