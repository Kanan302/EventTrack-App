import 'dart:io';

import 'package:ascca_app/data/repositories/profile/update_profile/update_profile_repository.dart';
import 'package:ascca_app/shared/services/local/secure_service.dart';
import 'package:ascca_app/ui/utils/messages/messages.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final UpdateProfileRepository repository;
  final SecureService secureService;

  // bool _hasFetched = false;

  UpdateProfileCubit({required this.repository, required this.secureService})
    : super(UpdateProfileInitial());

  Future<void> updateProfile(
    String? fullName,
    String? aboutMe,
    File? profilePictureFile,
  ) async {
    emit(UpdateProfileLoading());
    try {
      final userId = await secureService.userId;
      if (userId == null) {
        emit(UpdateProfileFailure(errorMessage: Messages.userIdNotFound));
        return;
      }

      await repository.updateProfile(
        userId,
        fullName,
        aboutMe,
        profilePictureFile,
      );
      emit(UpdateProfileSuccess());
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(UpdateProfileFailure(errorMessage: errorMessage));
    }
  }
}
