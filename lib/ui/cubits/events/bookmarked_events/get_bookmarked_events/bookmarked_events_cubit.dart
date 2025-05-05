import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../data/models/events/bookmarked_events/bookmarked_events_model.dart';
import '../../../../../data/repositories/events/bookmark_events/get_bookmarked_events/bookmarked_events_repository.dart';
import '../../../../../shared/services/local/secure_service.dart';

part 'bookmarked_events_state.dart';

class BookmarkedEventsCubit extends Cubit<BookmarkedEventsState> {
  final BookmarkedEventsRepository repository;
  final SecureService secureService;

  BookmarkedEventsCubit({required this.repository, required this.secureService})
    : super(BookmarkedEventsInitial());

  Future<void> getBookmarkedEvents(BuildContext context) async {
    emit(BookmarkedEventsLoading());

    try {
      final userId = await secureService.userId;
      if (userId == null || userId.isEmpty) {
        emit(
          BookmarkedEventsFailure(
            errorMessage: AppLocalizations.of(context).userIdNotFound,
          ),
        );
        return;
      }

      final intUserId = int.tryParse(userId);

      if (intUserId == null) {
        emit(
          BookmarkedEventsFailure(
            errorMessage: AppLocalizations.of(context).wrongUserId,
          ),
        );
        return;
      }

      final events = await repository.getBookmarkedEvents(intUserId, context);

      emit(BookmarkedEventsSuccess(events: events));
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(BookmarkedEventsFailure(errorMessage: errorMessage));
    }
  }
}
