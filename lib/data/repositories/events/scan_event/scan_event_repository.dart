import 'dart:convert';

import 'package:ascca_app/data/models/events/scan_event/scan_event_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../ui/utils/messages/messages.dart';
import '../../../models/events/scan_event/scan_event_request_model.dart';
import '../../../services/events/events_api_client.dart';

class ScanEventRepository {
  final EventsApiClient _eventsApiClient;

  const ScanEventRepository(this._eventsApiClient);

  Future<ScanEventResponseModel> scanEvent(String qrText) async {
    try {
      final request = ScanEventRequestModel(qrText: qrText);
      debugPrint("📤 Göndərilən JSON: ${jsonEncode(request.toJson())}");
      final response = await _eventsApiClient.scanEvent(request);
      debugPrint("scan event response: $response");
      return response;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final errorMessage = e.message ?? Messages.unknownError;
      if (statusCode == 404) {
        throw Exception(Messages.notFoundEvents);
      } else if (statusCode == 400) {
        throw Exception(Messages.alreadyScanned);
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
