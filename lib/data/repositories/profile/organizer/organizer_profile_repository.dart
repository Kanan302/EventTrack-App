import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../../generated/l10n/app_localizations.dart';
import '../../../models/profile/organizer/organizer_profile_model.dart';
import '../../../services/profile/profile_api_client.dart';

class OrganizerProfileRepository {
  final ProfileApiClient _profileApiClient;

  OrganizerProfileRepository(this._profileApiClient);

  Future<OrganizerProfileModel> getOrganizerData(
    int organizerId,
    BuildContext context,
  ) async {
    try {
      final response = await _profileApiClient.getOrganizerData(organizerId);
      // debugPrint('response: ${response.length}');
      return response;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final errorMessage =
          e.message ?? AppLocalizations.of(context).unknownError;
      if (statusCode == 404) {
        throw Exception(AppLocalizations.of(context).notFoundAdmin);
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
