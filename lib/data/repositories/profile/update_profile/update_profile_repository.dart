import 'dart:io';

import 'package:ascca_app/data/services/profile/profile_api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../ui/utils/messages/messages.dart';

class UpdateProfileRepository {
  final ProfileApiClient _profileApiClient;

  UpdateProfileRepository(this._profileApiClient);

  Future<void> updateProfile(
    String userId,
    String? fullName,
    String? aboutMe,
    File? profilePictureFile,
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
      final errorMessage = e.message ?? Messages.unknownError;
      if (statusCode == 404) {
        throw Exception(Messages.notFoundUser);
      } else if (statusCode == 500) {
        throw Exception(Messages.problemWithSystem);
      } else {
        throw Exception('${Messages.anErrorOccurred} $errorMessage');
      }
    } catch (e) {
      throw Exception('${Messages.anErrorOccurred} $e');
    }
  }
}
