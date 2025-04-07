part of 'top_events_cubit.dart';

abstract class TopEventsState extends Equatable {
  const TopEventsState();

  @override
  List<Object> get props => [];
}

class TopEventsInitial extends TopEventsState {}

class TopEventsLoading extends TopEventsState {}

class TopEventsSuccess extends TopEventsState {
  final List<TopEventsModel> topEvents;
  const TopEventsSuccess({required this.topEvents});

  @override
  List<Object> get props => [topEvents];
}

class TopEventsFailure extends TopEventsState {
  final String errorMessage;
  const TopEventsFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
