import 'package:ascca_app/shared/constants/app_texts.dart';
import 'package:ascca_app/ui/views/home/event_detail/widgets/_expandable_text.dart';
import 'package:flutter/material.dart';

class EventDetailAbout extends StatelessWidget {
  final String eventAbout;

  const EventDetailAbout({super.key, required this.eventAbout});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            AppTexts.aboutEvent,
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
