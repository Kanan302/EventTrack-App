import 'package:flutter/material.dart';
import '../../../../../shared/constants/app_texts.dart';

class CalendarTab extends StatefulWidget {
  const CalendarTab({super.key});

  @override
  State<CalendarTab> createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab> {
  // final eventDateService = CreateEventDateService();
  // final eventStartDateTimeController = TextEditingController();
  // final eventEndDateTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts.calendar),
        // actions: [
        //   IconButton(
        //     onPressed:
        //         () => showCreateEventDateModal(
        //           context,
        //           eventStartDateTimeController,
        //           eventEndDateTimeController,
        //           eventDateService,
        //         ),
        //     icon: Icon(Icons.filter_alt_outlined),
        //   ),
        // ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('calendar tab')],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   eventStartDateTimeController.dispose();
  //   eventEndDateTimeController.dispose();
  //   super.dispose();
  // }
}
