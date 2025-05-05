import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../models/events/create_event/create_event_request_model.dart';
import '../../../services/events/events_api_client.dart';

class CreateEventRepository {
  final EventsApiClient _eventsApiClient;

  CreateEventRepository(this._eventsApiClient);

  Future<void> createEvent(
    CreateEventRequestModel createEventRequestModel,
    BuildContext context,
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
      final errorMessage =
          e.message ?? AppLocalizations.of(context).unknownError;
      if (statusCode == 404) {
        throw Exception(AppLocalizations.of(context).notFoundUser);
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
