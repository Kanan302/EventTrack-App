import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repositories/events/delete_event/delete_event_repository.dart';

part 'delete_event_state.dart';

class DeleteEventCubit extends Cubit<DeleteEventState> {
  final DeleteEventRepository repository;

  DeleteEventCubit({required this.repository}) : super(DeleteEventInitial());

  Future<void> deleteEvent(BuildContext context, String eventId) async {
    emit(DeleteEventLoading());
    try {
      await repository.deleteEvent(eventId, context);
      emit(DeleteEventSuccess());
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(DeleteEventFailure(errorMessage: errorMessage));
    }
  }
}
