import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class DeleteEventModel {
  final int? code;
  final String? message;
  final dynamic response;

  DeleteEventModel({this.code, this.message, this.response});

  Map<String, dynamic> toJson() {
    return {'code': code, 'message': message, 'response': response};
  }

  factory DeleteEventModel.fromJson(Map<String, dynamic> json) {
    return DeleteEventModel(
      code: json['code'],
      message: json['message'],
      response: json['response'],
    );
  }
}
