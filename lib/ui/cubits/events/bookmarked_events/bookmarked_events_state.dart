part of 'bookmarked_events_cubit.dart';

abstract class BookmarkedEventsState extends Equatable {
  const BookmarkedEventsState();

  @override
  List<Object> get props => [];
}

class BookmarkedEventsInitial extends BookmarkedEventsState {}

class BookmarkedEventsLoading extends BookmarkedEventsState {}

class BookmarkedEventsSuccess extends BookmarkedEventsState {
  final List<BookmarkedEventsModel> events;

  const BookmarkedEventsSuccess({required this.events});

  @override
  List<Object> get props => [events];
}

class BookmarkedEventsFailure extends BookmarkedEventsState {
  final String errorMessage;

  const BookmarkedEventsFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
