part of 'export_event_cubit.dart';

abstract class ExportEventState extends Equatable {
  const ExportEventState();

  @override
  List<Object> get props => [];
}

class ExportEventInitial extends ExportEventState {}

class ExportEventLoading extends ExportEventState {}

class ExportEventSuccess extends ExportEventState {}

class ExportEventFailure extends ExportEventState {
  final String errorMessage;

  const ExportEventFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
