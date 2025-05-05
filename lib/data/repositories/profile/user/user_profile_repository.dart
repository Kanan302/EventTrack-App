import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../models/profile/user/user_profile_model.dart';
import '../../../services/profile/profile_api_client.dart';

class UserProfileRepository {
  final ProfileApiClient _profileApiClient;

  UserProfileRepository(this._profileApiClient);

  Future<UserProfileModel> getUserData(int userId, BuildContext context) async {
    try {
      final response = await _profileApiClient.getUserData(userId);
      return response;
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
