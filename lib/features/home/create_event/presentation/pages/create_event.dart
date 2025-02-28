import 'package:ascca_app/features/home/create_event/presentation/widgets/create_event_app_bar.dart';
import 'package:flutter/material.dart';

class CreateEventPage extends StatelessWidget {
  const CreateEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreateEventAppbar(),
      body: SafeArea(child: Center(child: Text('create event page'))),
    );
  }
}
