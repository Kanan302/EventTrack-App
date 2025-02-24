import 'package:equatable/equatable.dart';

abstract class AuthLoginState extends Equatable {
  const AuthLoginState();

  @override
  List<Object?> get props => [];
}

class AuthLoginInitial extends AuthLoginState {}

class AuthLoginLoading extends AuthLoginState {}

class AuthLoginSuccess extends AuthLoginState {}

class AuthLoginFailure extends AuthLoginState {
  final String errorMessage;

  const AuthLoginFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
