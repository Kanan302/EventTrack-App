import 'package:ascca_app/data/models/auth/auth_new_password/auth_new_password_request_model.dart';
import 'package:ascca_app/data/services/auth/auth_api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../ui/utils/messages/messages.dart';

class AuthNewPasswordRepository {
  final AuthApiClient _authApiClient;

  AuthNewPasswordRepository(this._authApiClient);

  Future<void> newPassword(
    AuthNewPasswordRequestModel authNewPasswordRequestModel,
  ) async {
    try {
      final response = await _authApiClient.newPassword(
        authNewPasswordRequestModel,
      );

      debugPrint('Response $response');
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
