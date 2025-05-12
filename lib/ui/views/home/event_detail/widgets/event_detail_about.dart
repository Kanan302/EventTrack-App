import 'package:flutter/material.dart';

import '../../../../../generated/l10n/app_localizations.dart';
import 'expandable_text.dart';

class EventDetailAbout extends StatelessWidget {
  final String eventAbout;

  const EventDetailAbout({super.key, required this.eventAbout});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            AppLocalizations.of(context).aboutEvent,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: ExpandableText(text: eventAbout),
        ),
      ],
    );
  }
}
