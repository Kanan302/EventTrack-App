import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../models/events/bookmarked_events/bookmarked_events_model.dart';
import '../../../../services/events/events_api_client.dart';

class BookmarkedEventsRepository {
  final EventsApiClient _eventsApiClient;

  BookmarkedEventsRepository(this._eventsApiClient);

  Future<List<BookmarkedEventsModel>> getBookmarkedEvents(
    int userId,
    BuildContext context,
  ) async {
    try {
      final response = await _eventsApiClient.getBookmarkedEvents(userId);
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
          '${AppLocalizations.of(context).anErrorOccurred}$errorMessage',
        );
      }
    } catch (e) {
      throw Exception('${AppLocalizations.of(context).anErrorOccurred} $e');
    }
  }
}
