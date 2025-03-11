part of 'user_profile_cubit.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileSuccess extends UserProfileState {
  final UserProfileModel user;

  const UserProfileSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class UserProfileFailure extends UserProfileState {
  final String errorMessage;

  const UserProfileFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
