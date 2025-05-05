import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../data/models/profile/user/user_profile_model.dart';
import '../../../../data/repositories/profile/user/user_profile_repository.dart';
import '../../../../shared/services/local/secure_service.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final UserProfileRepository repository;
  final SecureService secureService;
  bool _hasFetched = false;

  UserProfileCubit({required this.repository, required this.secureService})
    : super(UserProfileInitial());

  Future<void> getUserData(
    BuildContext context, {
    bool forceRefresh = false,
  }) async {
    if (_hasFetched && !forceRefresh) return;

    emit(UserProfileLoading());
    try {
      final userId = await secureService.userId;
      if (userId == null || userId.isEmpty) {
        emit(
          UserProfileFailure(
            errorMessage: AppLocalizations.of(context).userIdNotFound,
          ),
        );
        return;
      }

      final intUserId = int.tryParse(userId);

      if (intUserId == null) {
        emit(
          UserProfileFailure(
            errorMessage: AppLocalizations.of(context).wrongUserId,
          ),
        );
        return;
      }

      final user = await repository.getUserData(intUserId, context);
      emit(UserProfileSuccess(user));
      _hasFetched = true;
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(UserProfileFailure(errorMessage: errorMessage));
    }
  }
}
