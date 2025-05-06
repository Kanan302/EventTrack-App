import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../generated/l10n/app_localizations.dart';
import '../../../models/auth/auth_reset_password/auth_reset_password_request_model.dart';
import '../../../services/auth/auth_api_client.dart';

class AuthResetPasswordRepository {
  final AuthApiClient _authApiClient;

  AuthResetPasswordRepository(this._authApiClient);

  Future<void> resetPassword(
    AuthResetPasswordRequestModel authResetPasswordRequestModel,
    BuildContext context,
  ) async {
    try {
      final response = await _authApiClient.resetPassword(
        authResetPasswordRequestModel,
      );

      debugPrint('Response: $response');

      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString('resetEmail', authResetPasswordRequestModel.email!);

      debugPrint('Şifrəniz sıfırlandı, e-poçt qeyd olundu.');
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final errorMessage =
          e.message ?? AppLocalizations.of(context).unknownError;
      if (statusCode == 404) {
        throw Exception(AppLocalizations.of(context).notFoundUser);
      } else if (statusCode == 500) {
        throw Exception(AppLocalizations.of(context).problemWithSystem);
      } else {
        throw Exception(
          '${AppLocalizations.of(context).anErrorOccurred} $errorMessage',
        );
      }
    } catch (e) {
      throw Exception('${AppLocalizations.of(context).anErrorOccurred} $e');
    }
  }
}
