import 'package:ascca_app/views/home/profile_tab/features/notifications/widgets/notification_app_bar.dart';
import 'package:flutter/material.dart';

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
