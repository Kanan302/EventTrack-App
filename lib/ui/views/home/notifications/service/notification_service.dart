import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../shared/constants/app_routes.dart';

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> init(BuildContext context) async {
    await _requestPermission();

    // Foreground – App açıq olanda
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showDialog(
        context,
        message.notification?.title,
        message.notification?.body,
      );
    });

    // Background – App arxa planda, bildirişə klik olunub
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('Arxa planda kliklə açıldı: ${message.notification?.title}');
      _handleMessageClick(context, message);
    });

    // Terminated – App bağlı idi, bildiriş kliklə açılıb
    RemoteMessage? initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      debugPrint(
        'App bağlı idi, kliklə açıldı: ${initialMessage.notification?.title}',
      );
      _handleMessageClick(context, initialMessage);
    }
  }

  Future<void> _requestPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      debugPrint("Bildiriş icazəsi verilmədi");
    }
  }

  Future<String?> getFcmToken() async {
    try {
      final token = await _messaging.getToken();
      debugPrint('Alınan FCM Token: $token');
      return token;
    } catch (e) {
      debugPrint("FCM token alınarkən xəta: $e");
      return null;
    }
  }

  void _showDialog(BuildContext context, String? title, String? body) {
    if (context.mounted) {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: Text(title ?? 'Bildiriş'),
              content: Text(body ?? ''),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Bağla'),
                ),
              ],
            ),
      );
    }
  }

  void _handleMessageClick(BuildContext context, RemoteMessage message) {
    if (context.mounted) {
      context.push(AppRoutes.notification.path);
    }
  }
}
