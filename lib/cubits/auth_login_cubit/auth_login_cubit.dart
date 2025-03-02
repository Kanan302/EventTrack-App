import 'package:ascca_app/core/errors/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_keys.dart';
import '../../../../../core/utils/app_routes.dart';
import '../../../../../core/services/jwt/dio_configuration.dart';
import '../../../../../core/services/local/secure_service.dart';
import 'auth_login_state.dart';

class AuthLoginCubit extends Cubit<AuthLoginState> {
  final SecureService _secureStorage;

  AuthLoginCubit({required SecureService secureStorage})
    : _secureStorage = secureStorage,
      super(AuthLoginInitial());

  Future<void> loginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    emit(AuthLoginLoading());

    try {
      final response = await baseDio.post(
        '/auth/login',
        data: {'email': email.trim(), 'password': password.trim()},
      );

      if (response.statusCode == 200) {
        final accessToken =
            response.data[AppKeys.response][AppKeys.data][AppKeys.accessToken];
        final refreshToken =
            response.data[AppKeys.response][AppKeys.data][AppKeys.refreshToken];
        final userId =
            response.data[AppKeys.response][AppKeys.data][AppKeys.userId];
        final status =
            response.data[AppKeys.response][AppKeys.data][AppKeys.status];

        await _secureStorage.saveAccessToken(accessToken);
        await _secureStorage.saveRefreshToken(refreshToken);
        await _secureStorage.saveUserId(userId);
        await _secureStorage.saveUserStatus(status.toString());

        debugPrint('Message: ${AppKeys.message}');
        emit(AuthLoginSuccess());

        if (context.mounted) {
          context.go(
            AppRoutes.home.path,
            extra: {'message': 'Daxil olma uğurlu oldu', 'isSuccess': true},
          );
        }
      } else {
        _handleError(context, 'Naməlum xəta baş verdi.');
      }
    } on DioException catch (e) {
      final errorMessage = e.message ?? '';

      if (errorMessage.contains('status code of 404')) {
        _handleError(context, 'Belə istifadəçi tapılmadı.');
      } else if (errorMessage.contains('status code of 500')) {
        _handleError(context, 'Sistemdə problem var, üzr istəyirik.');
      } else {
        _handleError(context, 'Xəta baş verdi: $errorMessage');
      }
    } catch (e) {
      _handleError(context, 'Daxil olarkən bilinməyən xəta baş verdi: $e');
    }
  }

  void _handleError(BuildContext context, String message) {
    emit(AuthLoginFailure(message));
    FlushbarService.showFlushbar(
      context: context,
      message: message,
      isSuccess: false,
    );
    debugPrint(message);
  }
}
