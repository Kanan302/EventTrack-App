import 'package:flutter/material.dart';

import '../widgets/notification_app_bar.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NotificationAppBar(),
      body: SafeArea(child: Center(child: Text('notifications will be here'))),
      // body: SafeArea(
      //   child: BlocBuilder<NotificationCubit, NotificationState>(
      //     builder: (context, state) {
      //       if (state.notifications.isEmpty) {
      //         return const Center(child: Text('No notifications yet.'));
      //       }
      //       return ListView.builder(
      //         itemCount: state.notifications.length,
      //         itemBuilder: (context, index) {
      //           return ListTile(title: Text(state.notifications[index]));
      //         },
      //       );
      //     },
      //   ),
      // ),
    );
  }
}
