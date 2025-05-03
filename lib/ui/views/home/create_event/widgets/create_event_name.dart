import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../utils/validators/validators.dart';
import 'create_event_formfield.dart';

class CreateEventName extends StatelessWidget {
  final TextEditingController eventNameController;

  const CreateEventName({super.key, required this.eventNameController});

  @override
  Widget build(BuildContext context) {
    return CreateEventFormField(
      labelText: AppLocalizations.of(context).eventName,
      controller: eventNameController,
      validator: Validators.writeEventName,
    );
  }
}
