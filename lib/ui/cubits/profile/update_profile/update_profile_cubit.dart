import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../data/repositories/profile/update_profile/update_profile_repository.dart';
import '../../../../shared/services/local/secure_service.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final UpdateProfileRepository repository;
  final SecureService secureService;

  // bool _hasFetched = false;

  UpdateProfileCubit({required this.repository, required this.secureService})
    : super(UpdateProfileInitial());

  Future<void> updateProfile(
    BuildContext context,
    String? fullName,
    String? aboutMe,
    File? profilePictureFile,
  ) async {
    emit(UpdateProfileLoading());
    try {
      final userId = await secureService.userId;
      if (userId == null) {
        emit(
          UpdateProfileFailure(
            errorMessage: AppLocalizations.of(context).userIdNotFound,
          ),
        );
        return;
      }

      await repository.updateProfile(
        userId,
        fullName,
        aboutMe,
        profilePictureFile,
        context,
      );
      emit(UpdateProfileSuccess());
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(UpdateProfileFailure(errorMessage: errorMessage));
    }
  }
}
