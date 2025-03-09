part of 'create_event_cubit.dart';

abstract class CreateEventState extends Equatable {
  const CreateEventState();

  @override
  List<Object> get props => [];
}

class CreateEventInitial extends CreateEventState {}

class CreateEventLoading extends CreateEventState {}

class CreateEventSuccess extends CreateEventState {}

class CreateEventFailure extends CreateEventState {
  final String errorMessage;

  const CreateEventFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
