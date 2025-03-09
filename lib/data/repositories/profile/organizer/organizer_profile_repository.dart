import 'package:ascca_app/data/models/profile/organizer/organizer_profile_model.dart';
import 'package:ascca_app/data/services/profile/profile_api_client.dart';
import 'package:dio/dio.dart';

class OrganizerProfileRepository {
  final ProfileApiClient _profileApiClient;

  OrganizerProfileRepository(this._profileApiClient);

  Future<OrganizerProfileModel> getOrganizerData(int organizerId) async {
    try {
      final response = await _profileApiClient.getOrganizerData(organizerId);
      // debugPrint('response: ${response.length}');
      return response;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final errorMessage = e.message ?? 'Bilinməyən xəta baş verdi.';
      if (statusCode == 404) {
        throw Exception(
          'Təşkilatçı məlumatı tapılmadı. Zəhmət olmasa, sorğunu yoxlayın və yenidən cəhd edin.',
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
