import 'package:flutter/material.dart';

class ProfileName extends StatelessWidget {
  final String name;
  final String aboutMe;

  const ProfileName({super.key, required this.name, required this.aboutMe});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),

        Text(
          aboutMe,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
