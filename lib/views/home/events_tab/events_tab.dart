import 'package:flutter/material.dart';

import '../../../core/utils/app_texts.dart';

class EventsTab extends StatelessWidget {
  const EventsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts.events),
        centerTitle: true,
        actions: [
          Transform.translate(
            offset: Offset(-8, 0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.search_outlined),
            ),
          ),
        ],
      ),
      body: SafeArea(child: Center(child: Text('events tab'))),
    );
  }
}
