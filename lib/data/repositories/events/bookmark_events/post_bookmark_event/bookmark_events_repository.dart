import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../services/events/events_api_client.dart';

class BookmarkEventsRepository {
  final EventsApiClient _eventsApiClient;

  const BookmarkEventsRepository(this._eventsApiClient);

  Future<String> bookmarkEvent(
    String userId,
    String eventId,
    BuildContext context,
  ) async {
    try {
      final response = await _eventsApiClient.bookmarkEvent(userId, eventId);
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
