import 'package:ascca_app/shared/constants/app_keys.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UpdateProfileResponseModel {
  final int? id;
  final String? fullName;
  final String? aboutMe;
  final String? profilePictureUrl;

  UpdateProfileResponseModel({
    this.id,
    this.fullName,
    this.aboutMe,
    this.profilePictureUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      AppKeys.response: {
        AppKeys.data: {
          'id': id,
          if (fullName != null) 'fullName': fullName,
          if (aboutMe != null) 'aboutMe': aboutMe,
          if (profilePictureUrl != null) 'profilePictureUrl': profilePictureUrl,
        },
      },
    };
  }

  factory UpdateProfileResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json[AppKeys.response][AppKeys.data];
    return UpdateProfileResponseModel(
      id: data['id'] as int?,
      fullName: data['fullName'] as String?,
      aboutMe: data['aboutMe'] as String?,
      profilePictureUrl: data['profilePictureUrl'] as String?,
    );
  }
}
