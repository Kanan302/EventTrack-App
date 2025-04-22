import 'package:ascca_app/shared/constants/app_texts.dart';
import 'package:ascca_app/ui/utils/validators/validators.dart';
import 'package:flutter/material.dart';

import 'create_event_formfield.dart';

class CreateEventDescription extends StatelessWidget {
  final TextEditingController eventDescriptionController;

  const CreateEventDescription({
    super.key,
    required this.eventDescriptionController,
  });

  @override
  Widget build(BuildContext context) {
    return CreateEventFormField(
      labelText: AppTexts.eventDescription,
      controller: eventDescriptionController,
      validator: Validators.writeEventDescription,
    );
  }
}
