import 'package:ascca_app/data/models/auth/auth_new_password/auth_new_password_request_model.dart';
import 'package:ascca_app/data/services/auth/auth_api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthNewPasswordRepository {
  final AuthApiClient _authApiClient;
  AuthNewPasswordRepository(this._authApiClient);

  Future<void> newPassword(
    AuthNewPasswordRequestModel authNewPasswordRequestModel,
  ) async {
    try {
      final response = await _authApiClient.newPassword(authNewPasswordRequestModel);

      debugPrint('Resonse $response');
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final errorMessage = e.message ?? 'Bilinməyən xəta baş verdi.';
      if (statusCode == 404) {
        throw Exception(
          'İstifadəçi tapılmadı. Zəhmət olmasa, e-poçt ünvanını yoxlayın.',
        );
      } else if (statusCode == 500) {
        throw Exception('Sistemdə problem var, üzr istəyirik.');
      } else {
        throw Exception('Xəta baş verdi: $errorMessage');
      }
    } catch (e) {
      throw Exception('Gözlənilməz xəta baş verdi: $e');
    }
  }
}
