import 'package:ascca_app/data/models/events/top_events/top_events_model.dart';
import 'package:ascca_app/data/services/events/events_api_client.dart';
import 'package:dio/dio.dart';

class TopEventsRepository {
  final EventsApiClient _eventsApiClient;

  TopEventsRepository(this._eventsApiClient);

  Future<List<TopEventsModel>> getTopEvents() async {
    try {
      return await _eventsApiClient.getTopEvents();
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
