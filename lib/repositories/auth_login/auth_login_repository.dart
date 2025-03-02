import 'package:ascca_app/core/services/jwt/dio_configuration.dart';
import 'package:ascca_app/core/services/local/secure_service.dart';
import 'package:ascca_app/core/utils/app_keys.dart';
import 'package:ascca_app/models/auth_model.dart';
import 'package:dio/dio.dart';

class AuthLoginRepository {
  final SecureService _secureStorage;
  AuthLoginRepository({required SecureService secureStorage})
    : _secureStorage = secureStorage;

  Future<void> loginUser(AuthModel model) async {
    try {
      final response = await baseDio.post(
        '/auth/login',
        data: model.toJson(),
      );

      if (response.statusCode == 200) {
        final accessToken =
            response.data[AppKeys.response][AppKeys.data][AppKeys.accessToken];
        final refreshToken =
            response.data[AppKeys.response][AppKeys.data][AppKeys.refreshToken];
        final userId =
            response.data[AppKeys.response][AppKeys.data][AppKeys.userId];
        final status =
            response.data[AppKeys.response][AppKeys.data][AppKeys.status];

        await _secureStorage.saveAccessToken(accessToken);
        await _secureStorage.saveRefreshToken(refreshToken);
        await _secureStorage.saveUserId(userId);
        await _secureStorage.saveUserStatus(status.toString());
      } else {
        throw Exception('Naməlum xəta baş verdi.');
      }
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
