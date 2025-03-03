import 'package:flutter/material.dart';

class SnackBarService {
  static void showSnackBar(
    BuildContext context,
    String message,
    Color backgroundColor,
    {MessageType messageType = MessageType.info}
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

enum MessageType {info,error,warning}
