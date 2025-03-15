part of 'update_profile_cubit.dart';

abstract class UpdateProfileState extends Equatable {
  const UpdateProfileState();

  @override
  List<Object> get props => [];
}

class UpdateProfileInitial extends UpdateProfileState {}

class UpdateProfileLoading extends UpdateProfileState {}

class UpdateProfileSuccess extends UpdateProfileState {}

class UpdateProfileFailure extends UpdateProfileState {
  final String errorMessage;
  const UpdateProfileFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
