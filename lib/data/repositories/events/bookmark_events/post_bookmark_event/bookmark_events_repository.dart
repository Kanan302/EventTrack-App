import 'package:ascca_app/data/services/events/events_api_client.dart';
import 'package:dio/dio.dart';

class BookmarkEventsRepository {
  final EventsApiClient _eventsApiClient;

  const BookmarkEventsRepository(this._eventsApiClient);

  Future<String> bookmarkEvent(String userId, String eventId) async {
    try {
      final response = await _eventsApiClient.bookmarkEvent(userId, eventId);
      return response;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final errorMessage = e.message ?? 'Bilinməyən xəta baş verdi.';
      if (statusCode == 404) {
        throw Exception('Tədbir tapılmadı. Zəhmət olmasa, yenidən yoxlayın.');
      } else if (statusCode == 500) {
        throw Exception('Sistemdə problem var, üzr istəyirik.');
      } else {
        throw Exception('Xəta baş verdi: $errorMessage');
      }
    } catch (e) {
      throw Exception('Gözlənilməz xəta baş verdi: $e');
    }
  }
}
