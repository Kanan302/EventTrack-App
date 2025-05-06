import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../generated/l10n/app_localizations.dart';
import '../../../../shared/constants/app_keys.dart';
import '../../../models/auth/auth_registration/auth_registration_request.dart';
import '../../../services/auth/auth_api_client.dart';

class AuthRegistrationRepository {
  final AuthApiClient _authApiClient;

  AuthRegistrationRepository(this._authApiClient);

  Future<void> register(
    AuthRegistrationRequestModel authRegistrationRequestModel,
    BuildContext context,
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
          e.response?.data[AppKeys.message] ??
          AppLocalizations.of(context).unknownError;
      debugPrint('Dio error: $serverMessage');

      if (statusCode == 404 || statusCode == 403) {
        throw Exception(serverMessage);
      } else if (statusCode == 500) {
        throw Exception(AppLocalizations.of(context).problemWithSystem);
      } else {
        throw Exception(
          '${AppLocalizations.of(context).anErrorOccurred} $serverMessage',
        );
      }
    } catch (e) {
      throw Exception('${AppLocalizations.of(context).anErrorOccurred} $e');
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
