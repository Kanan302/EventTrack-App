import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UpdateProfileRequestModel {
  final String? fullName;
  final String? aboutMe;
  final String? profilePictureUrl;

  UpdateProfileRequestModel({
    this.fullName,
    this.aboutMe,
    this.profilePictureUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      if (fullName != null) 'fullName': fullName,
      if (aboutMe != null) 'aboutMe': aboutMe,
      if (profilePictureUrl != null) 'profilePictureUrl': profilePictureUrl,
    };
  }

  factory UpdateProfileRequestModel.fromJson(Map<String, dynamic> json) {
    return UpdateProfileRequestModel(
      fullName: json['fullName'],
      aboutMe: json['aboutMe'],
      profilePictureUrl: json['profilePictureUrl'],
    );
  }
}
