import 'package:ascca_app/data/models/events/delete_event/delete_event_model.dart';
import 'package:ascca_app/data/services/events/events_api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../ui/utils/messages/messages.dart';

class DeleteEventRepository {
  final EventsApiClient _eventsApiClient;

  const DeleteEventRepository(this._eventsApiClient);

  Future<DeleteEventModel> deleteEvent(String eventId) async {
    try {
      final response = await _eventsApiClient.deleteEvent(eventId);
      debugPrint("Response: $response");
      return response;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final errorMessage = e.message ?? Messages.unknownError;
      if (statusCode == 404) {
        throw Exception(Messages.notFoundEvents);
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
