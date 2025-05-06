import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../generated/l10n/app_localizations.dart';
import '../../../services/profile/profile_api_client.dart';

class UpdateProfileRepository {
  final ProfileApiClient _profileApiClient;

  UpdateProfileRepository(this._profileApiClient);

  Future<void> updateProfile(
    String userId,
    String? fullName,
    String? aboutMe,
    File? profilePictureFile,
    BuildContext context,
  ) async {
    try {
      MultipartFile? profilePicture;

      if (profilePictureFile != null) {
        profilePicture = await MultipartFile.fromFile(
          profilePictureFile.path,
          filename: profilePictureFile.path.split('/').last,
        );
      }

      final response = await _profileApiClient.updateProfile(
        userId,
        fullName,
        aboutMe,
        profilePicture,
      );

      debugPrint('Response: $response');
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final errorMessage =
          e.message ?? AppLocalizations.of(context).unknownError;
      if (statusCode == 404) {
        throw Exception(AppLocalizations.of(context).notFoundUser);
      } else if (statusCode == 500) {
        throw Exception(AppLocalizations.of(context).problemWithSystem);
      } else {
        throw Exception(
          '${AppLocalizations.of(context).anErrorOccurred} $errorMessage',
        );
      }
    } catch (e) {
      throw Exception('${AppLocalizations.of(context).anErrorOccurred} $e');
    }
  }
}
