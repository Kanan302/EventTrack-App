import 'package:flutter/material.dart';

class OrganizerAbout extends StatelessWidget {
  final String about;

  const OrganizerAbout({super.key, required this.about});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        about,
        style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
      ),
    );
  }
}
