import 'package:ascca_app/data/models/auth/auth_reset_password/auth_reset_password_request_model.dart';
import 'package:ascca_app/data/services/auth/auth_api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../ui/utils/messages/messages.dart';

class AuthResetPasswordRepository {
  final AuthApiClient _authApiClient;

  AuthResetPasswordRepository(this._authApiClient);

  Future<void> resetPassword(
    AuthResetPasswordRequestModel authResetPasswordRequestModel,
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
      final errorMessage = e.message ?? Messages.unknownError;
      if (statusCode == 404) {
        throw Exception(Messages.notFoundUser);
      } else if (statusCode == 500) {
        throw Exception(Messages.problemWithSystem);
      } else {
        throw Exception('${Messages.anErrorOccurred} $errorMessage');
      }
    } catch (e) {
      throw Exception('${Messages.anErrorOccurred} $e');
    }
  }
}
