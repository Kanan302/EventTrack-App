part of 'scan_event_cubit.dart';

abstract class ScanEventState extends Equatable {
  const ScanEventState();

  @override
  List<Object> get props => [];
}

class ScanEventInitial extends ScanEventState {}

class ScanEventLoading extends ScanEventState {}

class ScanEventSuccess extends ScanEventState {}

class ScanEventFailure extends ScanEventState {
  final String errorMessage;

  const ScanEventFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
