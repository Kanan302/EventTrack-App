import 'package:flutter/material.dart';

class ProfileName extends StatelessWidget {
  const ProfileName({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'username',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          'about',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
