import 'package:ascca_app/data/models/events/bookmarked_events/bookmarked_events_model.dart';
import 'package:ascca_app/data/repositories/events/bookmark_events/get_bookmarked_events/bookmarked_events_repository.dart';
import 'package:ascca_app/shared/services/local/secure_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bookmarked_events_state.dart';

class BookmarkedEventsCubit extends Cubit<BookmarkedEventsState> {
  final BookmarkedEventsRepository repository;
  final SecureService secureService;

  BookmarkedEventsCubit({required this.repository, required this.secureService})
    : super(BookmarkedEventsInitial());

  Future<void> getBookmarkedEvents() async {
    emit(BookmarkedEventsLoading());

    try {
      final userId = await secureService.userId;
      if (userId == null || userId.isEmpty) {
        emit(BookmarkedEventsFailure(errorMessage: "User ID tapılmadı!"));
        return;
      }

      final intUserId = int.tryParse(userId);

      if (intUserId == null) {
        emit(BookmarkedEventsFailure(errorMessage: "User ID düzgün deyil!"));
        return;
      }

      final events = await repository.getBookmarkedEvents(intUserId);

      emit(BookmarkedEventsSuccess(events: events));
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(BookmarkedEventsFailure(errorMessage: errorMessage));
    }
  }
}
