import 'package:flutter/material.dart';

import '../../../../../generated/l10n/app_localizations.dart';

class OrganizerEventTitle extends StatelessWidget {
  const OrganizerEventTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        AppLocalizations.of(context).events,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
