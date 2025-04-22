import 'package:ascca_app/data/repositories/events/bookmark_events/post_bookmark_event/bookmark_events_repository.dart';
import 'package:ascca_app/shared/services/local/secure_service.dart';
import 'package:ascca_app/ui/utils/messages/messages.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bookmark_events_state.dart';

class BookmarkEventsCubit extends Cubit<BookmarkEventsState> {
  final BookmarkEventsRepository repository;
  final SecureService secureService;

  BookmarkEventsCubit({required this.repository, required this.secureService})
    : super(BookmarkEventsInitial());

  Future<void> bookmarkEvent(String eventId) async {
    try {
      final userId = await secureService.userId;

      if (userId == null || userId.isEmpty) {
        emit(BookmarkEventsFailure(errorMessage: Messages.userIdNotFound));

        return;
      }
      await repository.bookmarkEvent(userId, eventId);
      emit(BookmarkEventsSuccess());
    } catch (e) {
      debugPrint("Error: ${e.toString()}");

      final errorMessage = e.toString().replaceFirst('Exception: ', '');

      emit(BookmarkEventsFailure(errorMessage: errorMessage));
    }
  }
}
