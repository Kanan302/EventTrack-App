import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/app_routes.dart';
import '../../core/errors/flushbar.dart';
import '../../core/errors/snackbar.dart';
import '../../core/services/jwt/dio_configuration.dart';

part 'auth_new_password_state.dart';

class AuthNewPasswordCubit extends Cubit<AuthNewPasswordState> {
  AuthNewPasswordCubit() : super(AuthNewPasswordInitial());

  Future<void> newPassword({
    required BuildContext context,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(AuthNewPasswordLoading());

    try {
      final response = await baseDio.post(
        '/auth/resetPassword',
        data: {'newPassword': newPassword, 'confirmPassword': confirmPassword},
      );

      if (response.statusCode == 200) {
        emit(AuthNewPasswordSuccess());

        SnackBarService.showSnackBar(
          context,
          'Şifrə uğurla yeniləndi!',
          AppColors.black,
        );

        context.go(AppRoutes.login.path);
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
    emit(AuthNewPasswordFailure(message));
    FlushbarService.showFlushbar(
      context: context,
      message: message,
      isSuccess: false,
    );
    debugPrint(message);
  }
}
