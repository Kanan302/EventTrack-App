import 'package:ascca_app/data/models/events/create_event/create_event_request_model.dart';
import 'package:ascca_app/data/services/events/events_api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';

class CreateEventRepository {
  final EventsApiClient _eventsApiClient;
  CreateEventRepository(this._eventsApiClient);

  Future<void> createEvent(
    CreateEventRequestModel createEventRequestModel,
  ) async {
    try {
      final response = await _eventsApiClient.createEvent(
        createEventRequestModel.name!,
        createEventRequestModel.about!,
        createEventRequestModel.location!,
        createEventRequestModel.imageURL!,
        createEventRequestModel.startDate!.toIso8601String(),
        createEventRequestModel.endDate!.toIso8601String(),
        createEventRequestModel.organizerId!,
      );

      // print(createEventRequestModel.toJson());

      debugPrint('Response: $response');
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final errorMessage = e.message ?? 'Bilinməyən xəta baş verdi.';
      if (statusCode == 404) {
        throw Exception(
          'İstifadəçi tapılmadı. Zəhmət olmasa, e-poçt ünvanını yoxlayın.',
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
