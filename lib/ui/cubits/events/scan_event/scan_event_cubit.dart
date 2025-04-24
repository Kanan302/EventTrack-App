import 'package:ascca_app/data/repositories/events/scan_event/scan_event_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'scan_event_state.dart';

class ScanEventCubit extends Cubit<ScanEventState> {
  final ScanEventRepository repository;

  ScanEventCubit({required this.repository}) : super(ScanEventInitial());

  Future<void> scanEvent(String qrText) async {
    emit(ScanEventLoading());
    try {
      await repository.scanEvent(qrText);
      emit(ScanEventSuccess());
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(ScanEventFailure(errorMessage: errorMessage));
    }
  }
}
