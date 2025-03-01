import 'package:flutter/material.dart';

import '../../../core/constants/app_texts.dart';

class CalendarTab extends StatelessWidget {
  const CalendarTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppTexts.calendar)),
      body: SafeArea(child: Center(child: Text('calendar tab'))),
    );
  }
}
