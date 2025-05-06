// import 'package:ascca_app/shared/utils/app_keys.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../generated/l10n/app_localizations.dart';
import '../../../../shared/services/local/secure_service.dart';
import '../../../models/auth/auth_login/auth_login_request_model.dart';
import '../../../services/auth/auth_api_client.dart';

class AuthLoginRepository {
  final SecureService _secureStorage;
  final AuthApiClient _authApiClient;

  AuthLoginRepository(this._secureStorage, this._authApiClient);

  Future<void> login(
    AuthLoginRequestModel authLoginRequestModel,
    BuildContext context,
  ) async {
    //  bool isAuth = await _authApiClient.login(mail, password);
    // final response = await baseDio.post('/auth/login', data: model.toJson());

    try {
      final response = await _authApiClient.login(authLoginRequestModel);

      debugPrint("Response: $response");

      // final accessToken = response[AppKeys.accessToken];
      // final refreshToken = response[AppKeys.refreshToken];
      // final userId = response[AppKeys.userId];
      // final status = response[AppKeys.status];
      final accessToken = response.accessToken;
      final refreshToken = response.refreshToken;
      final userId = response.userId;
      final status = response.status;

      await _secureStorage.saveAccessToken(accessToken!);
      await _secureStorage.saveRefreshToken(refreshToken!);
      await _secureStorage.saveUserId(userId!);
      await _secureStorage.saveUserStatus(status.toString());
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
