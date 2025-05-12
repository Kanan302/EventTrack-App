import 'package:flutter/material.dart';

import '../widgets/notification_app_bar.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NotificationAppBar(),
      body: SafeArea(child: Center(child: Text('notification page'))),
    );
  }
}
