import 'package:ascca_app/data/repositories/events/export_event/export_event_repository.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/services/local/secure_service.dart';
import '../../../utils/messages/messages.dart';

part 'export_event_state.dart';

class ExportEventCubit extends Cubit<ExportEventState> {
  final ExportEventRepository repository;
  final SecureService secureService;

  ExportEventCubit({required this.repository, required this.secureService})
    : super(ExportEventInitial());

  Future<void> exportEvent(String eventId) async {
    emit(ExportEventLoading());
    try {
      final userId = await secureService.userId;

      if (userId == null || userId.isEmpty) {
        emit(ExportEventFailure(errorMessage: Messages.userIdNotFound));

        return;
      }

      await _attemptExport(userId, eventId);

      emit(ExportEventSuccess());
    } catch (e) {
      debugPrint("Error: ${e.toString()}");

      final errorMessage = e.toString().replaceFirst('Exception: ', '');

      emit(ExportEventFailure(errorMessage: errorMessage));
    }
  }

  Future<void> _attemptExport(String userId, String eventId) async {
    try {
      await repository.exportEvent(userId, eventId);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        debugPrint('Token expired, refreshing...');
        final newToken = await secureService.accessToken;
        if (newToken != null) {
          await repository.exportEvent(userId, eventId);
        } else {
          throw Exception('Failed to refresh token');
        }
      } else {
        rethrow;
      }
    }
  }
}
