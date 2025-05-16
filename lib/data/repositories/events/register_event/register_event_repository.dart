import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../generated/l10n/app_localizations.dart';
import '../../../services/events/events_api_client.dart';

class RegisterEventRepository {
  final EventsApiClient _eventsApiClient;

  const RegisterEventRepository(this._eventsApiClient);

  Future<void> registerEvent(
    String userId,
    String eventId,
    BuildContext context,
  ) async {
    try {
      final response = await _eventsApiClient.registerEvent(userId, eventId);
      debugPrint('Response register event: $response');
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final errorMessage =
          e.response?.data['message'] ??
          AppLocalizations.of(context).unknownError;

      if (statusCode == 404) {
        throw Exception(AppLocalizations.of(context).notFoundEvents);
      } else if (statusCode == 400) {
        throw Exception(AppLocalizations.of(context).userAlreadyRegistered);
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
