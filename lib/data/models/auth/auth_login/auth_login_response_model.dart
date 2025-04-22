import 'package:ascca_app/shared/constants/app_keys.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../ui/utils/messages/messages.dart';

@JsonSerializable()
class AuthLoginResponseModel {
  final String? accessToken;
  final String? refreshToken;
  final String? userId;
  final String? status;

  AuthLoginResponseModel({
    this.accessToken,
    this.refreshToken,
    this.userId,
    this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      AppKeys.response: {
        AppKeys.data: {
          if (accessToken != null) AppKeys.accessToken: accessToken,
          if (refreshToken != null) AppKeys.refreshToken: refreshToken,
          if (userId != null) AppKeys.userId: userId,
          if (status != null) AppKeys.status: status,
        },
      },
    };
  }

  factory AuthLoginResponseModel.fromJson(Map<String, dynamic> json) {
    if (json[AppKeys.response][AppKeys.data] == null) {
      throw Exception(Messages.notFoundData);
    }
    return AuthLoginResponseModel(
      accessToken:
          json[AppKeys.response][AppKeys.data][AppKeys.accessToken] as String?,
      refreshToken:
          json[AppKeys.response][AppKeys.data][AppKeys.refreshToken] as String?,
      userId: json[AppKeys.response][AppKeys.data][AppKeys.userId] as String?,
      status: json[AppKeys.response][AppKeys.data][AppKeys.status] as String?,
    );
  }

  // // fromJson və toJson metodlarını json_serializable avtomatik yaradır
  // factory AuthLoginResponseModel.fromJson(Map<String, dynamic> json) =>
  //     _$AuthLoginResponseModelFromJson(json);

  // Map<String, dynamic> toJson() => _$AuthLoginResponseModelToJson(this);
}
