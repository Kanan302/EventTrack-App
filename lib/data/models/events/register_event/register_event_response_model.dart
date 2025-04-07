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
    return RegisterEventResponseModel(
      data: json[AppKeys.response][AppKeys.data] as String?,
    );
  }
}
