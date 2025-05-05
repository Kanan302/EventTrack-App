import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../utils/validators/validators.dart';
import 'create_event_formfield.dart';

class CreateEventCity extends StatelessWidget {
  final TextEditingController eventCityController;

  const CreateEventCity({super.key, required this.eventCityController});

  @override
  Widget build(BuildContext context) {
    return CreateEventFormField(
      labelText: AppLocalizations.of(context).eventCity,
      controller: eventCityController,
      validator: (value) => Validators.writeEventCity(value, context),
    );
  }
}
