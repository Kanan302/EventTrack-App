import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../generated/l10n/app_localizations.dart';
import '../../../models/events/scan_event/scan_event_request_model.dart';
import '../../../models/events/scan_event/scan_event_response_model.dart';
import '../../../services/events/events_api_client.dart';

class ScanEventRepository {
  final EventsApiClient _eventsApiClient;

  const ScanEventRepository(this._eventsApiClient);

  Future<ScanEventResponseModel> scanEvent(
    String qrText,
    BuildContext context,
  ) async {
    try {
      final request = ScanEventRequestModel(qrText: qrText);
      debugPrint("📤 Göndərilən JSON: ${jsonEncode(request.toJson())}");
      final response = await _eventsApiClient.scanEvent(request);
      debugPrint("scan event response: $response");
      return response;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final errorMessage =
          e.message ?? AppLocalizations.of(context).unknownError;
      if (statusCode == 404) {
        throw Exception(AppLocalizations.of(context).notFoundEvents);
      } else if (statusCode == 400) {
        throw Exception(AppLocalizations.of(context).alreadyScanned);
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
