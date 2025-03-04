import 'package:ascca_app/data/models/auth/auth_registration/auth_registration_request.dart';
import 'package:ascca_app/data/services/auth_api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRegistrationRepository {
  final AuthApiClient _authApiClient;

  AuthRegistrationRepository(this._authApiClient);

  Future<void> register(
    AuthRegistrationRequestModel authRegistrationRequestModel,
  ) async {
    try {
      final response = _authApiClient.register(authRegistrationRequestModel);

      debugPrint('Response: $response');

      await _saveRegistrationData(
        authRegistrationRequestModel.fullName!,
        authRegistrationRequestModel.email!,
        authRegistrationRequestModel.password!,
        authRegistrationRequestModel.confirmPassword!,
      );
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

  Future<void> _saveRegistrationData(
    String fullName,
    String email,
    String password,
    String confirmPassword,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('registerFullName', fullName);
    await prefs.setString('registerEmail', email);
    await prefs.setString('registerPassword', password);
    await prefs.setString('registerConfirmPassword', confirmPassword);
  }
}
