import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../generated/l10n/app_localizations.dart';
import '../../../models/events/delete_event/delete_event_model.dart';
import '../../../services/events/events_api_client.dart';

class DeleteEventRepository {
  final EventsApiClient _eventsApiClient;

  const DeleteEventRepository(this._eventsApiClient);

  Future<DeleteEventModel> deleteEvent(
    String eventId,
    BuildContext context,
  ) async {
    try {
      final response = await _eventsApiClient.deleteEvent(eventId);
      debugPrint("Response: $response");
      return response;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final errorMessage =
          e.message ?? AppLocalizations.of(context).unknownError;
      if (statusCode == 404) {
        throw Exception(AppLocalizations.of(context).notFoundEvents);
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
