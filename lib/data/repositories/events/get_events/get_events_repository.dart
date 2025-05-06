import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../../generated/l10n/app_localizations.dart';
import '../../../models/events/get_events/get_events_model.dart';
import '../../../services/events/events_api_client.dart';

class GetEventsRepository {
  final EventsApiClient _eventsApiClient;

  GetEventsRepository(this._eventsApiClient);

  Future<List<GetEventsModel>> getEvents(BuildContext context) async {
    try {
      final response = await _eventsApiClient.getEvents();
      // debugPrint('response: ${response.length}');
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
