import 'package:ascca_app/data/models/events/bookmarked_events/bookmarked_events_model.dart';
import 'package:ascca_app/data/services/events/events_api_client.dart';
import 'package:dio/dio.dart';

import '../../../../../ui/utils/messages/messages.dart';

class BookmarkedEventsRepository {
  final EventsApiClient _eventsApiClient;

  BookmarkedEventsRepository(this._eventsApiClient);

  Future<List<BookmarkedEventsModel>> getBookmarkedEvents(int userId) async {
    try {
      final response = await _eventsApiClient.getBookmarkedEvents(userId);
      return response;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final errorMessage = e.message ?? Messages.unknownError;
      if (statusCode == 404) {
        throw Exception(Messages.notFoundEvents);
      } else if (statusCode == 500) {
        throw Exception(Messages.problemWithSystem);
      } else {
        throw Exception('${Messages.anErrorOccurred}$errorMessage');
      }
    } catch (e) {
      throw Exception('${Messages.anErrorOccurred} $e');
    }
  }
}
