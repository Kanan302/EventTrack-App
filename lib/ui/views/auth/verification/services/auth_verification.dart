import 'package:ascca_app/shared/utils/app_routes.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../shared/theme/app_colors.dart';
import '../../../../utils/snackbar.dart';
import '../../../../../shared/services/jwt/dio_configuration.dart';

class AuthVerificationService {
  Future<bool> verification({
    required String otp,
    required BuildContext context,
  }) async {
    try {
      final response = await baseDio.post(
        '/auth/verifyRegistration',
        data: {"otp": otp.toString()},
        options: Options(validateStatus: (status) => status != null),
      );

      var responseData = response.data;
      String? message = responseData['message'];
      var data = responseData['response']?['data'] ?? {};

      debugPrint('Message: $message');
      debugPrint('Data: $data');

      if (response.statusCode == 200) {
        SnackBarService.showSnackBar(
          context,
          'Təsdiqləmə uğurla tamamlandı!',
          AppColors.black,
        );
        context.go(AppRoutes.home.path);
        return true;
      } else {
        SnackBarService.showSnackBar(
          context,
          'Təsdiqləmə xəta verdi: ${response.statusCode}',
          AppColors.red,
        );
        return false;
      }
    } catch (e) {
      debugPrint('Təsdiqləmə zamanı xəta oldu: $e');
      SnackBarService.showSnackBar(
        context,
        'Təsdiqləmə zamanı xəta oldu: $e',
        AppColors.red,
      );
      return false;
    }
  }

  Future<bool> verificationForResetPassword({
    required String otp,
    required BuildContext context,
  }) async {
    try {
      final response = await baseDio.post(
        '/auth/otpReset',
        data: {"otp": otp},
        options: Options(validateStatus: (status) => status != null),
      );

      var responseData = response.data;
      String? message = responseData['message'];
      var data = responseData['response']?['data'] ?? {};

      debugPrint('Message: $message');
      debugPrint('Data: $data');

      if (response.statusCode == 200) {
        SnackBarService.showSnackBar(
          context,
          'Təsdiqləmə uğurla tamamlandı',
          AppColors.black,
        );
        return true;
      } else {
        SnackBarService.showSnackBar(
          context,
          'Təsdiqləmə vaxtı xəta: ${response.statusCode}',
          AppColors.red,
        );
        return false;
      }
    } catch (e) {
      debugPrint('Təsdiqləmə vaxtı xəta: $e');

      if (e is DioException &&
          e.response != null &&
          e.response!.statusCode == 404) {
        SnackBarService.showSnackBar(
          context,
          'Yanlış OTP. Zəhmət olmasa, e-poçtunuzu yoxlayın və yenidən cəhd edin.',
          AppColors.red,
        );
      } else {
        SnackBarService.showSnackBar(
          context,
          'Təsdiqləmə zamanı xəta oldu: $e',
          AppColors.red,
        );
      }

      return false;
    }
  }
}
