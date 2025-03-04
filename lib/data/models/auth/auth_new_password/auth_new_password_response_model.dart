import 'package:ascca_app/shared/constants/app_keys.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AuthNewPasswordResponseModel {
  final String? data;

  AuthNewPasswordResponseModel({this.data});

  Map<String, dynamic> toJson() {
    return {
      AppKeys.response: {AppKeys.data: data},
    };
  }

  factory AuthNewPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthNewPasswordResponseModel(
      data: json[AppKeys.response][AppKeys.data] as String?,
    );
  }
}
