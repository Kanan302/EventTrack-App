import 'dart:io';

import 'package:ascca_app/data/services/profile/profile_api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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
      final errorMessage = e.message ?? 'Bilinməyən xəta baş verdi.';
      if (statusCode == 404) {
        throw Exception(
          'İstifadəçi tapılmadı. Zəhmət olmasa, yenidən yoxlayın.',
        );
      } else if (statusCode == 500) {
        throw Exception('Sistemdə problem var, üzr istəyirik.');
      } else {
        throw Exception('Xəta baş verdi: $errorMessage');
      }
    } catch (e) {
      throw Exception('Gözlənilməz xəta baş verdi: $e');
    }
  }
}
