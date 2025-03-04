part of 'auth_reset_password_cubit.dart';

abstract class AuthResetPasswordState extends Equatable {
  const AuthResetPasswordState();

  @override
  List<Object?> get props => [];
}

class AuthResetPasswordInitial extends AuthResetPasswordState {}

class AuthResetPasswordLoading extends AuthResetPasswordState {}

class AuthResetPasswordSuccess extends AuthResetPasswordState {}

class AuthResetPasswordFailure extends AuthResetPasswordState {
  final String errorMessage;

  const AuthResetPasswordFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
