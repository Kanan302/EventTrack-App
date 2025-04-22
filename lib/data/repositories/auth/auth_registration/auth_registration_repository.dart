import 'package:ascca_app/data/models/auth/auth_registration/auth_registration_request.dart';
import 'package:ascca_app/data/services/auth/auth_api_client.dart';
import 'package:ascca_app/shared/constants/app_keys.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../ui/utils/messages/messages.dart';

class AuthRegistrationRepository {
  final AuthApiClient _authApiClient;

  AuthRegistrationRepository(this._authApiClient);

  Future<void> register(
    AuthRegistrationRequestModel authRegistrationRequestModel,
  ) async {
    try {
      final response = await _authApiClient.register(
        authRegistrationRequestModel,
      );

      debugPrint('Response: $response');

      await _saveRegistrationData(
        authRegistrationRequestModel.fullName!,
        authRegistrationRequestModel.email!,
        authRegistrationRequestModel.password!,
        authRegistrationRequestModel.confirmPassword!,
      );
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final serverMessage =
          e.response?.data[AppKeys.message] ?? Messages.unknownError;
      debugPrint('Dio error: $serverMessage');

      if (statusCode == 404 || statusCode == 403) {
        throw Exception(serverMessage);
      } else if (statusCode == 500) {
        throw Exception(Messages.problemWithSystem);
      } else {
        throw Exception('${Messages.anErrorOccurred} $serverMessage');
      }
    } catch (e) {
      throw Exception('${Messages.anErrorOccurred} $e');
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
