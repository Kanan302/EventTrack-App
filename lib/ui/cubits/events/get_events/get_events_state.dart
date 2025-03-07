part of 'get_events_cubit.dart';

abstract class GetEventsState extends Equatable {
  const GetEventsState();

  @override
  List<Object> get props => [];
}

class GetEventsInitial extends GetEventsState {}

class GetEventsLoading extends GetEventsState {}

class GetEventsSuccess extends GetEventsState {
  final List<GetEventsModel> events;

  const GetEventsSuccess({required this.events});

  @override
  List<Object> get props => [events];
}

class GetEventsFailure extends GetEventsState {
  final String errorMessage;

  const GetEventsFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
