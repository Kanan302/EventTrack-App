// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class NotificationState {
//   final List<String> notifications;
//
//   NotificationState({required this.notifications});
//
//   NotificationState copyWith({List<String>? notifications}) {
//     return NotificationState(
//       notifications: notifications ?? this.notifications,
//     );
//   }
// }
//
// class NotificationCubit extends Cubit<NotificationState> {
//   NotificationCubit() : super(NotificationState(notifications: []));
//
//   void addNotification(String notification) {
//     final updatedList = List<String>.from(state.notifications)
//       ..add(notification);
//     emit(state.copyWith(notifications: updatedList));
//   }
//
//   void clearNotifications() {
//     emit(state.copyWith(notifications: []));
//   }
// }
