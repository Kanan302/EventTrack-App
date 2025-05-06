import 'package:flutter/material.dart';

import '../../../../../generated/l10n/app_localizations.dart';
import '../../../../utils/validators/validators.dart';
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
      labelText: AppLocalizations.of(context).eventDescription,
      controller: eventDescriptionController,
      validator: (value) => Validators.writeEventDescription(value, context),
    );
  }
}
