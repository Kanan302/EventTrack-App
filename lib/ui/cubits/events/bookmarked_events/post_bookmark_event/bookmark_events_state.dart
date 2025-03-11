part of 'bookmark_events_cubit.dart';

abstract class BookmarkEventsState extends Equatable {
  const BookmarkEventsState();

  @override
  List<Object> get props => [];
}

class BookmarkEventsInitial extends BookmarkEventsState {}

class BookmarkEventsLoading extends BookmarkEventsState {}

class BookmarkEventsSuccess extends BookmarkEventsState {}

class BookmarkEventsFailure extends BookmarkEventsState {
  final String errorMessage;
  const BookmarkEventsFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
