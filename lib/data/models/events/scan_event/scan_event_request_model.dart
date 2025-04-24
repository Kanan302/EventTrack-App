class ScanEventRequestModel {
  final String qrText;

  ScanEventRequestModel({required this.qrText});

  Map<String, dynamic> toJson() => {'qrText': qrText};

  factory ScanEventRequestModel.fromJson(Map<String, dynamic> json) {
    return ScanEventRequestModel(qrText: json['qrText']);
  }
}
