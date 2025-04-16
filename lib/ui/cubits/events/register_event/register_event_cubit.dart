import 'package:ascca_app/data/repositories/events/register_event/register_event_repository.dart';
import 'package:ascca_app/shared/services/local/secure_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_event_state.dart';

class RegisterEventCubit extends Cubit<RegisterEventState> {
  final RegisterEventRepository repository;
  final SecureService secureService;

  RegisterEventCubit({required this.repository, required this.secureService})
    : super(RegisterEventInitial());

  Future<void> registerEvent(String eventId) async {
    emit(RegisterEventLoading());
    try {
      final userId = await secureService.userId;

      if (userId == null || userId.isEmpty) {
        emit(RegisterEventFailure(errorMessage: "User ID tapılmadı!"));

        return;
      }
      await repository.registerEvent(userId, eventId);

      emit(RegisterEventSuccess());
    } catch (e) {
      debugPrint("Error: ${e.toString()}");

      final errorMessage = e.toString().replaceFirst('Exception: ', '');

      emit(RegisterEventFailure(errorMessage: errorMessage));
    }
  }
}
