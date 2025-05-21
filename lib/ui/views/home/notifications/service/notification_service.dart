// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// import 'notification_cubit.dart';
//
// class NotificationService {
//   static final FirebaseMessaging _firebaseMessaging =
//       FirebaseMessaging.instance;
//   static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   static final GlobalKey<NavigatorState> globalNavigatorKey =
//       GlobalKey<NavigatorState>();
//
//   static Future<void> init() async {
//     await _firebaseMessaging.requestPermission();
//     await _initLocalNotifications();
//     await _getFCMToken();
//     _setupFCMListeners();
//     await _checkInitialMessage();
//   }
//
//   static Future<void> _getFCMToken() async {
//     String? token = await _firebaseMessaging.getToken();
//     debugPrint("FCM Token: $token");
//   }
//
//   static Future<void> _initLocalNotifications() async {
//     const androidSettings = AndroidInitializationSettings(
//       '@mipmap/ic_launcher',
//     );
//     const initSettings = InitializationSettings(android: androidSettings);
//     await _localNotificationsPlugin.initialize(initSettings);
//   }
//
//   static void _setupFCMListeners() {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       _showLocalNotification(message);
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       _handleMessageNavigation(message);
//     });
//   }
//
//   static Future<void> _checkInitialMessage() async {
//     RemoteMessage? initialMessage =
//         await _firebaseMessaging.getInitialMessage();
//     if (initialMessage != null) {
//       _handleMessageNavigation(initialMessage);
//     }
//   }
//
//   static Future<void> _showLocalNotification(RemoteMessage message) async {
//     RemoteNotification? notification = message.notification;
//     if (notification != null) {
//       const androidDetails = AndroidNotificationDetails(
//         'channel_id',
//         'General Notifications',
//         importance: Importance.max,
//         priority: Priority.high,
//       );
//       const platformDetails = NotificationDetails(android: androidDetails);
//       await _localNotificationsPlugin.show(
//         notification.hashCode,
//         notification.title,
//         notification.body,
//         platformDetails,
//       );
//
//       // Bildirişi Cubit-ə göndər
//       BlocProvider.of<NotificationCubit>(
//         globalNavigatorKey.currentContext!,
//       ).addNotification('${notification.title}: ${notification.body}');
//     }
//   }
//
//   static void _handleMessageNavigation(RemoteMessage message) {
//     final targetPage = message.data['targetPage'];
//     if (targetPage == 'details') {
//       globalNavigatorKey.currentState?.pushNamed('/details');
//     }
//   }
//
//   static Future<void> subscribeToTopic(String topic) async {
//     await _firebaseMessaging.subscribeToTopic(topic);
//   }
//
//   static Future<void> unsubscribeFromTopic(String topic) async {
//     await _firebaseMessaging.unsubscribeFromTopic(topic);
//   }
// }
