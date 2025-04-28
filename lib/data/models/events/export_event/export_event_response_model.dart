class ExportEventResponseModel {
  final int? code;
  final String? message;
  final dynamic response;

  ExportEventResponseModel({this.code, this.message, this.response});

  Map<String, dynamic> toJson() {
    return {'code': code, 'message': message, 'response': response};
  }

  factory ExportEventResponseModel.fromJson(Map<String, dynamic> json) {
    return ExportEventResponseModel(
      code: json['code'],
      message: json['message'],
      response: json['response'],
    );
  }
}
