class AuthLoginRequestModel {
  final String? email;
  final String? password;
  final String? fcmToken;

  AuthLoginRequestModel({this.email, this.password, this.fcmToken});

  Map<String, dynamic> toJson() {
    return {
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      if (fcmToken != null) 'fcmToken': fcmToken,
    };
  }

  factory AuthLoginRequestModel.fromJson(Map<String, dynamic> json) {
    return AuthLoginRequestModel(
      email: json['email'],
      password: json['password'],
      fcmToken: json['fcmToken'],
    );
  }
}
