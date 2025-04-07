part of 'register_event_cubit.dart';

abstract class RegisterEventState extends Equatable {
  const RegisterEventState();

  @override
  List<Object> get props => [];
}

class RegisterEventInitial extends RegisterEventState {}

class RegisterEventLoading extends RegisterEventState {}

class RegisterEventSuccess extends RegisterEventState {}

class RegisterEventFailure extends RegisterEventState {
  final String errorMessage;
  const RegisterEventFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
