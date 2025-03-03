import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../../shared/theme/app_colors.dart';

class FlushbarService {
  static void showFlushbar({
    required BuildContext context,
    required String message,
    required bool isSuccess,
  }) {
    Flushbar(
      message: message,
      flushbarPosition: FlushbarPosition.TOP,
      borderColor: AppColors.lavenderBlue,
      borderWidth: 3,
      backgroundColor: isSuccess ? AppColors.blue : AppColors.red,
      borderRadius: BorderRadius.circular(16),
      margin: const EdgeInsets.all(20),
      duration: const Duration(seconds: 3),
    ).show(context);
  }
}
