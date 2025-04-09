import 'package:ascca_app/data/models/profile/update_profile/update_profile_request_model.dart';
import 'package:ascca_app/data/services/profile/profile_api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UpdateProfileRepository {
  final ProfileApiClient _profileApiClient;

  UpdateProfileRepository(this._profileApiClient);

  Future<void> updateProfile(
    String userId,
    UpdateProfileRequestModel updateProfileRequestModel,
  ) async {
    try {
      final response = await _profileApiClient.updateProfile(
        userId,
        updateProfileRequestModel.fullName ?? '',
        updateProfileRequestModel.aboutMe ?? '',
        updateProfileRequestModel.profilePicture ?? '',
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
