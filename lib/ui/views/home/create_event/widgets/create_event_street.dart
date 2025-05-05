import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../utils/validators/validators.dart';
import 'create_event_formfield.dart';

class CreateEventStreet extends StatelessWidget {
  final TextEditingController eventStreetController;

  const CreateEventStreet({super.key, required this.eventStreetController});

  @override
  Widget build(BuildContext context) {
    return CreateEventFormField(
      labelText: AppLocalizations.of(context).eventStreet,
      controller: eventStreetController,
      validator: (value) => Validators.writeEventStreet(value, context),
    );
  }
}
