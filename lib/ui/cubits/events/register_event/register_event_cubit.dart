import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repositories/events/register_event/register_event_repository.dart';
import '../../../../generated/l10n/app_localizations.dart';
import '../../../../shared/services/local/secure_service.dart';

part 'register_event_state.dart';

class RegisterEventCubit extends Cubit<RegisterEventState> {
  final RegisterEventRepository repository;
  final SecureService secureService;

  RegisterEventCubit({required this.repository, required this.secureService})
    : super(RegisterEventInitial());

  Future<void> registerEvent(BuildContext context, String eventId) async {
    emit(RegisterEventLoading());
    try {
      final userId = await secureService.userId;

      if (userId == null || userId.isEmpty) {
        emit(
          RegisterEventFailure(
            errorMessage: AppLocalizations.of(context).userIdNotFound,
          ),
        );

        return;
      }
      await repository.registerEvent(userId, eventId, context);

      emit(RegisterEventSuccess());
    } catch (e) {
      debugPrint("Error: ${e.toString()}");

      final errorMessage = e.toString().replaceFirst('Exception: ', '');

      emit(RegisterEventFailure(errorMessage: errorMessage));
    }
  }
}
