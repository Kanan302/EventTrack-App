import 'package:equatable/equatable.dart';

abstract class AuthRegistrationState extends Equatable {
  const AuthRegistrationState();

  @override
  List<Object?> get props => [];
}

class AuthRegistrationInitial extends AuthRegistrationState {}

class AuthRegistrationLoading extends AuthRegistrationState {}

class AuthRegistrationSuccess extends AuthRegistrationState {}

class AuthRegistrationFailure extends AuthRegistrationState {
  final String errorMessage;

  const AuthRegistrationFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
