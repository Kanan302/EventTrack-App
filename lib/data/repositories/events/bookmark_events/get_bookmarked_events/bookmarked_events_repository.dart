import 'package:ascca_app/data/models/events/bookmarked_events/bookmarked_events_model.dart';
import 'package:ascca_app/data/services/events/events_api_client.dart';
import 'package:dio/dio.dart';

class BookmarkedEventsRepository {
  final EventsApiClient _eventsApiClient;

  BookmarkedEventsRepository(this._eventsApiClient);

  Future<List<BookmarkedEventsModel>> getBookmarkedEvents(int userId) async {
    try {
      
    final response = await _eventsApiClient.getBookmarkedEvents(userId);
    return response;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final errorMessage = e.message ?? 'Bilinməyən xəta baş verdi.';
      if (statusCode == 404) {
        throw Exception(
          'Tədbirlər tapılmadı. Zəhmət olmasa, sorğunu yoxlayın və yenidən cəhd edin.',
        );
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
