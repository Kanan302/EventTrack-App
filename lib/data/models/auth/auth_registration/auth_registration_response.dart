import 'package:ascca_app/shared/constants/app_keys.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AuthRegistrationResponseModel {
  final String? data;

  AuthRegistrationResponseModel({this.data});

  Map<String, dynamic> toJson() {
    return {
      AppKeys.response: {AppKeys.data: data},
    };
  }

  factory AuthRegistrationResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthRegistrationResponseModel(
      data: json[AppKeys.response][AppKeys.data] as String?,
    );
  }
}
