import 'package:ascca_app/shared/constants/app_texts.dart';
import 'package:flutter/material.dart';

class OrganizerEventTitle extends StatelessWidget {
  const OrganizerEventTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        '${AppTexts.events}i',
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
