import 'package:ascca_app/data/models/profile/user/user_profile_model.dart';
import 'package:ascca_app/data/repositories/profile/user/user_profile_repository.dart';
import 'package:ascca_app/shared/services/local/secure_service.dart';
import 'package:ascca_app/ui/utils/messages/messages.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final UserProfileRepository repository;
  final SecureService secureService;
  bool _hasFetched = false;

  UserProfileCubit({required this.repository, required this.secureService})
    : super(UserProfileInitial());

  Future<void> getUserData({bool forceRefresh = false}) async {
    if (_hasFetched && !forceRefresh) return;

    emit(UserProfileLoading());
    try {
      final userId = await secureService.userId;
      if (userId == null || userId.isEmpty) {
        emit(UserProfileFailure(errorMessage: Messages.userIdNotFound));
        return;
      }

      final intUserId = int.tryParse(userId);

      if (intUserId == null) {
        emit(UserProfileFailure(errorMessage: Messages.wrongUserId));
        return;
      }

      final user = await repository.getUserData(intUserId);
      emit(UserProfileSuccess(user));
      _hasFetched = true;
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(UserProfileFailure(errorMessage: errorMessage));
    }
  }
}
