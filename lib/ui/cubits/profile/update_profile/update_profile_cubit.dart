import 'package:ascca_app/data/models/profile/update_profile/update_profile_request_model.dart';
import 'package:ascca_app/data/repositories/profile/update_profile/update_profile_repository.dart';
import 'package:ascca_app/shared/services/local/secure_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final UpdateProfileRepository repository;
  final SecureService secureService;

  UpdateProfileCubit({required this.repository, required this.secureService})
    : super(UpdateProfileInitial());

  Future<void> updateProfile(
    String fullName,
    String aboutMe,
    String profilePictureUrl,
  ) async {
    emit(UpdateProfileLoading());
    try {
      final userId = await secureService.userId;

      if (userId == null || userId.isEmpty) {
        emit(UpdateProfileFailure(errorMessage: "User ID tapılmadı!"));
        return;
      }
      final UpdateProfileRequestModel updateProfileRequestModel =
          UpdateProfileRequestModel(
            fullName: fullName,
            aboutMe: aboutMe,
            profilePictureUrl: profilePictureUrl,
          );

      await repository.updateProfile(userId, updateProfileRequestModel);
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(UpdateProfileFailure(errorMessage: errorMessage));
    }
  }
}
