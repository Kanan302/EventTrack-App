import 'package:ascca_app/data/models/profile/organizer/organizer_profile_model.dart';
import 'package:ascca_app/data/services/profile/profile_api_client.dart';
import 'package:dio/dio.dart';

import '../../../../ui/utils/messages/messages.dart';

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
      final errorMessage = e.message ?? Messages.unknownError;
      if (statusCode == 404) {
        throw Exception(Messages.notFoundAdmin);
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
