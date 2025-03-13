part of 'delete_event_cubit.dart';

abstract class DeleteEventState extends Equatable {
  const DeleteEventState();

  @override
  List<Object> get props => [];
}

class DeleteEventInitial extends DeleteEventState {}

class DeleteEventLoading extends DeleteEventState {}

class DeleteEventSuccess extends DeleteEventState {}

class DeleteEventFailure extends DeleteEventState {
  final String errorMessage;
  const DeleteEventFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
