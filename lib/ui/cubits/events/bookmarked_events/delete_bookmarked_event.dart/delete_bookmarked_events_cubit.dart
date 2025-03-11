import 'package:ascca_app/data/repositories/events/bookmark_events/delete_bookmarked_event/delete_bookmark_event_repository.dart';
import 'package:ascca_app/shared/services/local/secure_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'delete_bookmarked_events_state.dart';

class DeleteBookmarkedEventsCubit extends Cubit<DeleteBookmarkedEventsState> {
  final DeleteBookmarkEventsRepository repository;
  final SecureService secureService;

  DeleteBookmarkedEventsCubit({
    required this.repository,
    required this.secureService,
  }) : super(DeleteBookmarkedEventsInitial());

  Future<void> deleteBookmarkEvent(String eventId) async {
    emit(DeleteBookmarkedEventsLoading());
    try {
      final userId = await secureService.userId;

      if (userId == null || userId.isEmpty) {
        emit(DeleteBookmarkedEventsFailure(errorMessage: "User ID tapılmadı!"));
        return;
      }
      await repository.deleteBookmarkEvent(userId, eventId);
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(DeleteBookmarkedEventsFailure(errorMessage: errorMessage));
    }
  }
}
