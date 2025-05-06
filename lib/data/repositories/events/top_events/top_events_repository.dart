import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../../generated/l10n/app_localizations.dart';
import '../../../models/events/top_events/top_events_model.dart';
import '../../../services/events/events_api_client.dart';

class TopEventsRepository {
  final EventsApiClient _eventsApiClient;

  TopEventsRepository(this._eventsApiClient);

  Future<List<TopEventsModel>> getTopEvents(BuildContext context) async {
    try {
      return await _eventsApiClient.getTopEvents();
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
