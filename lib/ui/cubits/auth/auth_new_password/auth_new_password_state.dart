part of 'auth_new_password_cubit.dart';

abstract class AuthNewPasswordState extends Equatable {
  const AuthNewPasswordState();

  @override
  List<Object?> get props => [];
}

class AuthNewPasswordInitial extends AuthNewPasswordState {}

class AuthNewPasswordLoading extends AuthNewPasswordState {}

class AuthNewPasswordSuccess extends AuthNewPasswordState {}

class AuthNewPasswordFailure extends AuthNewPasswordState {
  final String errorMessage;

  const AuthNewPasswordFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
