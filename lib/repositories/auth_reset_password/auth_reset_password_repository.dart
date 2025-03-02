import 'package:ascca_app/core/services/jwt/dio_configuration.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthResetPasswordRepository {
  AuthResetPasswordRepository();

  Future<void> resetPassword(String email) async {
    try {
      final response = await baseDio.post(
        '/auth/requestPasswordReset',
        data: {'email': email},
      );

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('resetEmail', email);
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
