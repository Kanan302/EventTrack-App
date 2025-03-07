import 'package:ascca_app/data/models/events/get_events/get_events_model.dart';
import 'package:ascca_app/data/services/events/events_api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class GetEventsRepository {
  final EventsApiClient _eventsApiClient;

  GetEventsRepository(this._eventsApiClient);

  Future<List<GetEventsModel>> getEvents() async {
    try {
      final response = await _eventsApiClient.getEvents();
      debugPrint('response: ${response.length}');
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
