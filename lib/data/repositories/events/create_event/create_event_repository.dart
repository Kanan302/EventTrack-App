import 'package:ascca_app/data/models/events/create_event/create_event_request_model.dart';
import 'package:ascca_app/data/services/events/events_api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';

import '../../../../ui/utils/messages/messages.dart';

class CreateEventRepository {
  final EventsApiClient _eventsApiClient;

  CreateEventRepository(this._eventsApiClient);

  Future<void> createEvent(
    CreateEventRequestModel createEventRequestModel,
  ) async {
    try {
      FormData formData = FormData.fromMap({
        "name": createEventRequestModel.name,
        "about": createEventRequestModel.about,
        "city": createEventRequestModel.city,
        "street": createEventRequestModel.street,
        "lat": createEventRequestModel.lat,
        "lng": createEventRequestModel.lng,
        "image": await MultipartFile.fromFile(
          createEventRequestModel.image!.path,
        ),
        "startDate": createEventRequestModel.startDate!.toIso8601String(),
        "endDate": createEventRequestModel.endDate!.toIso8601String(),
        "organizerId": createEventRequestModel.organizerId,
      });

      final response = await _eventsApiClient.createEvent(formData);

      // print(createEventRequestModel.toJson());

      debugPrint('Response: $response');
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final errorMessage = e.message ?? Messages.unknownError;
      if (statusCode == 404) {
        throw Exception(Messages.notFoundUser);
      } else if (statusCode == 500) {
        throw Exception(Messages.problemWithSystem);
      } else {
        throw Exception('${Messages.anErrorOccurred} $errorMessage');
      }
    } catch (e) {
      throw Exception('${Messages.anErrorOccurred} $e');
    }
  }
}
