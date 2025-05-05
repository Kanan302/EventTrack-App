import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../services/events/events_api_client.dart';

class ExportEventRepository {
  final EventsApiClient _eventsApiClient;

  const ExportEventRepository(this._eventsApiClient);

  Future<void> exportEvent(
    String userId,
    String eventId,
    BuildContext context,
  ) async {
    try {
      final response = await _eventsApiClient.exportEvent(userId, eventId);
      debugPrint("Response for export event: $response");

      if (response.code != 200) {
        // server kodu 200 deyilse error atıram
        throw Exception(
          response.message ?? AppLocalizations.of(context).anErrorOccurred,
        );
      }
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
