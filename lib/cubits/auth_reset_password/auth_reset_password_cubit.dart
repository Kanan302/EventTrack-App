import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/errors/flushbar.dart';
import '../../core/services/jwt/dio_configuration.dart';
import '../../views/auth/verification/pages/verification.dart';

part 'auth_reset_password_state.dart';

class AuthResetPasswordCubit extends Cubit<AuthResetPasswordState> {
  AuthResetPasswordCubit() : super(AuthResetPasswordInitial());

  Future<void> resetPassword({
    required BuildContext context,
    required String email,
  }) async {
    emit(AuthResetPasswordLoading());

    try {
      final response = await baseDio.post(
        '/auth/requestPasswordReset',
        data: {'email': email},
      );

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('resetEmail', email);
        emit(AuthResetPasswordSuccess());

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const VerificationPage(),
            settings: const RouteSettings(arguments: {'fromReset': true}),
          ),
        );
      } else {
        _handleError(context, 'Naməlum xəta baş verdi.');
      }
    } on DioException catch (e) {
      _handleDioError(e, context);
    } catch (e) {
      _handleError(context, 'Bilinməyən xəta baş verdi: $e');
    }
  }

  void _handleDioError(DioException e, BuildContext context) {
    final statusCode = e.response?.statusCode;
    final errorMessage = e.message ?? 'Bilinməyən xəta baş verdi.';

    if (statusCode == 404) {
      _handleError(
        context,
        'stifadəçi tapılmadı. Zəhmət olmasa, e-poçt ünvanını yoxlayın',
      );
    } else if (statusCode == 500) {
      _handleError(context, 'Sistemdə problem var, üzr istəyirik.');
    } else {
      _handleError(context, 'Xəta baş verdi: $errorMessage');
    }
  }

  void _handleError(BuildContext context, String message) {
    emit(AuthResetPasswordFailure(message));
    FlushbarService.showFlushbar(
      context: context,
      message: message,
      isSuccess: false,
    );
    debugPrint(message);
  }
}
