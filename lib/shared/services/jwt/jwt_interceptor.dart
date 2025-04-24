import 'package:ascca_app/shared/constants/app_keys.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../injection/di.dart';
import '../local/secure_service.dart';
import 'dio_configuration.dart';

class JwtInterceptor extends Interceptor {
  final _secureStorage = getIt.get<SecureService>();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _secureStorage.accessToken;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    // if (response.statusCode == 200 &&
    //     response.data is Map &&
    //     response.data[AppKeys.accessToken] is String &&
    //     response.data[AppKeys.refreshToken] is String &&
    //     response.data[AppKeys.userId] is String &&
    //     response.data[AppKeys.status] is String) {
    //   final newAccessToken = response.data[AppKeys.accessToken] as String;
    //   final newRefreshToken = response.data[AppKeys.refreshToken] as String;
    //   final userId = response.data[AppKeys.userId] as String;
    //   final status = response.data[AppKeys.status] as String;

    //   await _secureStorage.saveAccessToken(newAccessToken);
    //   await _secureStorage.saveRefreshToken(newRefreshToken);
    //   await _secureStorage.saveUserId(userId);
    //   await _secureStorage.saveUserStatus(status);
    // }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // super.onError(err, handler);
    if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
      final newAccessToken = await refreshToken();
      if (newAccessToken != null) {
        baseDio.options.headers['Authorization'] = 'Bearer $newAccessToken';
        return handler.resolve(await baseDio.fetch(err.requestOptions));
      } else {
        await _secureStorage.clearToken();
        debugPrint('User must re-login');
        // return handler.next(err);
      }
    }
    super.onError(err, handler);
    // return handler.next(err);
  }

  Future<String?> refreshToken() async {
    try {
      final refreshToken = await _secureStorage.refreshToken;
      if (refreshToken == null) return null;

      final response = await baseDio.post(
        '/auth/refresh',
        data: {'existingRefreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        final responseData = response.data[AppKeys.response][AppKeys.data];
        final newAccessToken = responseData[AppKeys.accessToken];
        final newRefreshToken = responseData[AppKeys.refreshToken];

        await _secureStorage.saveAccessToken(newAccessToken);
        await _secureStorage.saveRefreshToken(newRefreshToken);

        return newAccessToken;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Refresh token error: $e');
      // await _secureStorage.clearToken();
      return null;
    }
  }
}
