import 'package:ascca_app/data/models/profile/user/user_profile_model.dart';
import 'package:ascca_app/data/repositories/profile/user/user_profile_repository.dart';
import 'package:ascca_app/shared/services/local/secure_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final UserProfileRepository repository;
  final SecureService secureService;

  UserProfileCubit({required this.repository, required this.secureService})
    : super(UserProfileInitial());

  Future<void> getUserData() async {
    emit(UserProfileLoading());
    try {
      final userId = await secureService.userId;
      if (userId == null || userId.isEmpty) {
        emit(UserProfileFailure(errorMessage: "User ID tapılmadı!"));
        return;
      }

      final intUserId = int.tryParse(userId);

      if (intUserId == null) {
        emit(UserProfileFailure(errorMessage: "User ID düzgün deyil!"));
        return;
      }

      final user = await repository.getUserData(intUserId);
      emit(UserProfileSuccess(user));
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(UserProfileFailure(errorMessage: errorMessage));
    }
  }
}
