import 'package:json_annotation/json_annotation.dart';

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

  factory AuthLoginResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['response']['data'] == null) {
      throw Exception('Cavabda "data" tapılmadı.');
    }
    return AuthLoginResponseModel(
      accessToken: json['response']['data']['accessToken'] as String?,
      refreshToken: json['response']['data']['refreshToken'] as String?,
      userId: json['response']['data']['userId'] as String?,
      status: json['response']['data']['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        if (accessToken != null) 'accessToken': accessToken,
        if (refreshToken != null) 'refreshToken': refreshToken,
        if (userId != null) 'userId': userId,
        if (status != null) 'status': status,
      },
    };
  }

  // // fromJson və toJson metodlarını json_serializable avtomatik yaradır
  // factory AuthLoginResponseModel.fromJson(Map<String, dynamic> json) =>
  //     _$AuthLoginResponseModelFromJson(json);

  // Map<String, dynamic> toJson() => _$AuthLoginResponseModelToJson(this);
}
