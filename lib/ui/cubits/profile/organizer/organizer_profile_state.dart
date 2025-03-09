part of 'organizer_profile_cubit.dart';

abstract class OrganizerProfileState extends Equatable {
  const OrganizerProfileState();

  @override
  List<Object> get props => [];
}

class OrganizerProfileInitial extends OrganizerProfileState {}

class OrganizerProfileLoading extends OrganizerProfileState {}

class OrganizerProfileSuccess extends OrganizerProfileState {
  final OrganizerProfileModel organizer;

  const OrganizerProfileSuccess(this.organizer);

  @override
  List<Object> get props => [organizer];
}

class OrganizerProfileFailure extends OrganizerProfileState {
  final String errorMessage;
  const OrganizerProfileFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
