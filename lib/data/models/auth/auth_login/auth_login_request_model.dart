class AuthLoginRequestModel {
  final String? email;
  final String? password;

  AuthLoginRequestModel({this.email, this.password});

  Map<String, dynamic> toJson() {
    return {
      if (email != null) 'email': email,
      if (password != null) 'password': password,
    };
  }

  factory AuthLoginRequestModel.fromJson(Map<String, dynamic> json) {
    return AuthLoginRequestModel(
      email: json['email'],
      password: json['password'],
    );
  }
}
