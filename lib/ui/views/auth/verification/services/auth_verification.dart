import 'package:ascca_app/shared/constants/app_keys.dart';
import 'package:ascca_app/shared/constants/app_routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../shared/services/jwt/dio_configuration.dart';
import '../../../../../shared/theme/app_colors.dart';
import '../../../../utils/messages/messages.dart';
import '../../../../utils/notifications/snackbar.dart';

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
      String? message = responseData[AppKeys.message];
      var data = responseData[AppKeys.response]?[AppKeys.data] ?? {};

      debugPrint('${AppKeys.message}: $message');
      debugPrint('${AppKeys.data}: $data');

      if (response.statusCode == 200) {
        SnackBarService.showSnackBar(
          context,
          Messages.verificationSuccessfully,
          AppColors.black,
        );
        context.go(AppRoutes.home.path);
        return true;
      } else {
        SnackBarService.showSnackBar(
          context,
          '${Messages.errorDuringVerification} ${response.statusCode}',
          AppColors.red,
        );
        return false;
      }
    } catch (e) {
      debugPrint('${Messages.errorDuringVerification} $e');
      SnackBarService.showSnackBar(
        context,
        '${Messages.errorDuringVerification} $e',
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
      String? message = responseData[AppKeys.message];
      var data = responseData[AppKeys.response]?[AppKeys.data] ?? {};

      debugPrint('${AppKeys.message}: $message');
      debugPrint('${AppKeys.data}: $data');

      if (response.statusCode == 200) {
        SnackBarService.showSnackBar(
          context,
          Messages.verificationSuccessfully,
          AppColors.black,
        );
        return true;
      } else {
        SnackBarService.showSnackBar(
          context,
          '${Messages.errorDuringVerification} ${response.statusCode}',
          AppColors.red,
        );
        return false;
      }
    } catch (e) {
      debugPrint('${Messages.errorDuringVerification} $e');

      if (e is DioException &&
          e.response != null &&
          e.response!.statusCode == 404) {
        SnackBarService.showSnackBar(
          context,
          Messages.checkMail,
          AppColors.red,
        );
      } else {
        SnackBarService.showSnackBar(
          context,
          '${Messages.errorDuringVerification} $e',
          AppColors.red,
        );
      }

      return false;
    }
  }
}
