import 'package:flutter/material.dart';

class ProfileName extends StatelessWidget {
  final String fullName;
  final String aboutMe;

  const ProfileName({super.key, required this.fullName, required this.aboutMe});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          fullName,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          aboutMe,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
