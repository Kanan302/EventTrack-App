import 'package:ascca_app/data/models/profile/user/user_profile_model.dart';
import 'package:ascca_app/data/services/profile/profile_api_client.dart';
import 'package:dio/dio.dart';

class UserProfileRepository {
  final ProfileApiClient _profileApiClient;

  UserProfileRepository(this._profileApiClient);

  Future<UserProfileModel> getUserData(int userId) async {
    try {
      final response = await _profileApiClient.getUserData(userId);
      return response;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final errorMessage = e.message ?? 'Bilinməyən xəta baş verdi.';
      if (statusCode == 404) {
        throw Exception(
          'İstifadəçi məlumatı tapılmadı. Zəhmət olmasa, sorğunu yoxlayın və yenidən cəhd edin.',
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
