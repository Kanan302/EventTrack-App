import 'package:ascca_app/shared/constants/app_keys.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AuthResetPasswordResponseModel {
  final String? data;

  AuthResetPasswordResponseModel({this.data});

  Map<String, dynamic> toJson() {
    return {
      AppKeys.response: {AppKeys.data: data},
    };
  }

  factory AuthResetPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResetPasswordResponseModel(
      data: json[AppKeys.response][AppKeys.data] as String?,
    );
  }
}
