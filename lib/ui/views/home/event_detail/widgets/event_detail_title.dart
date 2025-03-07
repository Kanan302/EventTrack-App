import 'package:flutter/material.dart';

class EventDetailTitle extends StatelessWidget {
  final String eventTitle;
  const EventDetailTitle({super.key, required this.eventTitle});

  @override
  Widget build(BuildContext context) {
    return Text(
      eventTitle.trim(),
      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    );
  }
}
