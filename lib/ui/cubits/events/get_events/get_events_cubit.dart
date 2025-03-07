import 'package:ascca_app/data/models/events/get_events/get_events_model.dart';
import 'package:ascca_app/data/repositories/events/get_events/get_events_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_events_state.dart';

class GetEventsCubit extends Cubit<GetEventsState> {
  final GetEventsRepository repository;

  GetEventsCubit({required this.repository}) : super(GetEventsInitial());

  Future<void> getEvents() async {
    emit(GetEventsLoading());

    try {
      final events = await repository.getEvents();
      debugPrint('Events from api: ${events.length}');
      emit(GetEventsSuccess(events: events));
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(GetEventsFailure(errorMessage));
    }
  }
}
