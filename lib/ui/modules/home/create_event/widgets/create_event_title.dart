import 'package:ascca_app/shared/constants/app_texts.dart';
import 'package:flutter/material.dart';

class CreateEventTitle extends StatelessWidget {
  const CreateEventTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        AppTexts.createYourEvent,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
