import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../shared/utils/app_routes.dart';
import '../../../../shared/services/local/secure_service.dart';
import '../../../../di.dart';

class LogOut {
  final _secureStorage = getIt.get<SecureService>();

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('remember_me', false);
    await _secureStorage.clearToken();

    if (context.mounted) {
      context.go(AppRoutes.login.path);
    }
  }
}
