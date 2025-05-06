import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../generated/l10n/app_localizations.dart';
import '../../../models/auth/auth_new_password/auth_new_password_request_model.dart';
import '../../../services/auth/auth_api_client.dart';

class AuthNewPasswordRepository {
  final AuthApiClient _authApiClient;

  AuthNewPasswordRepository(this._authApiClient);

  Future<void> newPassword(
    AuthNewPasswordRequestModel authNewPasswordRequestModel,
    BuildContext context,
  ) async {
    try {
      final response = await _authApiClient.newPassword(
        authNewPasswordRequestModel,
      );

      debugPrint('Response $response');
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
