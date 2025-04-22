import 'package:ascca_app/data/models/profile/user/user_profile_model.dart';
import 'package:ascca_app/data/services/profile/profile_api_client.dart';
import 'package:dio/dio.dart';

import '../../../../ui/utils/messages/messages.dart';

class UserProfileRepository {
  final ProfileApiClient _profileApiClient;

  UserProfileRepository(this._profileApiClient);

  Future<UserProfileModel> getUserData(int userId) async {
    try {
      final response = await _profileApiClient.getUserData(userId);
      return response;
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
