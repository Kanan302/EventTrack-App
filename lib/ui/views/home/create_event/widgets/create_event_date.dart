import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../utils/validators/validators.dart';
import '../service/create_event_date_service.dart';
import 'create_event_formfield.dart';

class CreateEventDate extends StatelessWidget {
  final TextEditingController eventStartDateTimeController;
  final TextEditingController eventEndDateTimeController;
  final CreateEventDateService dateService;

  const CreateEventDate({
    super.key,
    required this.eventStartDateTimeController,
    required this.eventEndDateTimeController,
    required this.dateService,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CreateEventFormField(
            labelText: AppLocalizations.of(context).startDate,
            controller: eventStartDateTimeController,
            onTap:
                () => pickDateTime(
                  context,
                  eventStartDateTimeController,
                  true,
                  dateService,
                ),
            validator:
                (value) => Validators.validateDateTimeFormat(value, context),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: CreateEventFormField(
            labelText: AppLocalizations.of(context).endDate,
            controller: eventEndDateTimeController,
            onTap:
                () => pickDateTime(
                  context,
                  eventEndDateTimeController,
                  false,
                  dateService,
                ),
            validator:
                (value) => Validators.validateDateTimeFormat(value, context),
          ),
        ),
      ],
    );
  }
}
