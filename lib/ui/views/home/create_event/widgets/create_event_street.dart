import 'package:ascca_app/shared/constants/app_texts.dart';
import 'package:ascca_app/ui/utils/validators/validators.dart';
import 'package:flutter/material.dart';

import 'create_event_formfield.dart';

class CreateEventStreet extends StatelessWidget {
  final TextEditingController eventStreetController;

  const CreateEventStreet({super.key, required this.eventStreetController});

  @override
  Widget build(BuildContext context) {
    return CreateEventFormField(
      labelText: AppTexts.eventStreet,
      controller: eventStreetController,
      validator: Validators.writeEventStreet,
    );
  }
}
