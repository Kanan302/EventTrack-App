import 'package:ascca_app/data/services/events/events_api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../../ui/utils/messages/messages.dart';

class ExportEventRepository {
  final EventsApiClient _eventsApiClient;

  const ExportEventRepository(this._eventsApiClient);

  Future<void> exportEvent(String userId, String eventId) async {
    try {
      final response = await _eventsApiClient.exportEvent(userId, eventId);
      debugPrint("Response for export event: $response");

      if (response.code != 200) {
        // server kodu 200 deyilse error atıram
        throw Exception(response.message ?? Messages.anErrorOccurred);
      }
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
