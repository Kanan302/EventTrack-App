class ScanEventResponseModel {
  final int? code;
  final String? message;
  final dynamic response;

  ScanEventResponseModel({this.code, this.message, this.response});

  Map<String, dynamic> toJson() {
    return {'code': code, 'message': message, 'response': response};
  }

  factory ScanEventResponseModel.fromJson(Map<String, dynamic> json) {
    return ScanEventResponseModel(
      code: json['code'],
      message: json['message'],
      response: json['response'],
    );
  }
}
