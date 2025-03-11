part of 'delete_bookmarked_events_cubit.dart';

abstract class DeleteBookmarkedEventsState extends Equatable {
  const DeleteBookmarkedEventsState();

  @override
  List<Object> get props => [];
}

class DeleteBookmarkedEventsInitial extends DeleteBookmarkedEventsState {}

class DeleteBookmarkedEventsLoading extends DeleteBookmarkedEventsState {}

class DeleteBookmarkedEventsSuccess extends DeleteBookmarkedEventsState {}

class DeleteBookmarkedEventsFailure extends DeleteBookmarkedEventsState {
  final String errorMessage;
  const DeleteBookmarkedEventsFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
