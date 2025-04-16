import 'package:ascca_app/shared/constants/app_keys.dart';

class RegisterEventResponseModel {
  final String? data;

  RegisterEventResponseModel({this.data});

  Map<String, dynamic> toJson() {
    return {
      AppKeys.response: {AppKeys.data: data},
    };
  }

  factory RegisterEventResponseModel.fromJson(Map<String, dynamic> json) {
    final response = json[AppKeys.response];
    final data = response != null ? response[AppKeys.data] as String? : null;

    return RegisterEventResponseModel(data: data);
  }
}
