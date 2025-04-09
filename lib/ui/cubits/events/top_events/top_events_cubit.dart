import 'package:ascca_app/data/models/events/top_events/top_events_model.dart';
import 'package:ascca_app/data/repositories/events/top_events/top_events_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_events_state.dart';

class TopEventsCubit extends Cubit<TopEventsState> {
  final TopEventsRepository repository;
  bool _hasFetched = false;

  TopEventsCubit({required this.repository}) : super(TopEventsInitial());

  Future<void> getTopEvents({bool forceRefresh = false}) async {
    if (_hasFetched && !forceRefresh) return;

    emit(TopEventsLoading());
    try {
      final topEvents = await repository.getTopEvents();
      emit(TopEventsSuccess(topEvents: topEvents));
      _hasFetched = true;
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(TopEventsFailure(errorMessage: errorMessage));
    }
  }
}
