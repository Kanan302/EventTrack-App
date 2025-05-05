import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../data/repositories/events/bookmark_events/delete_bookmarked_event/delete_bookmark_event_repository.dart';
import '../../../../../shared/services/local/secure_service.dart';

part 'delete_bookmarked_events_state.dart';

class DeleteBookmarkedEventsCubit extends Cubit<DeleteBookmarkedEventsState> {
  final DeleteBookmarkEventsRepository repository;
  final SecureService secureService;

  DeleteBookmarkedEventsCubit({
    required this.repository,
    required this.secureService,
  }) : super(DeleteBookmarkedEventsInitial());

  Future<void> deleteBookmarkEvent(BuildContext context, String eventId) async {
    emit(DeleteBookmarkedEventsLoading());
    try {
      final userId = await secureService.userId;

      if (userId == null || userId.isEmpty) {
        emit(
          DeleteBookmarkedEventsFailure(
            errorMessage: AppLocalizations.of(context).userIdNotFound,
          ),
        );
        return;
      }
      await repository.deleteBookmarkEvent(userId, eventId, context);
      emit(DeleteBookmarkedEventsSuccess());
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(DeleteBookmarkedEventsFailure(errorMessage: errorMessage));
    }
  }
}
