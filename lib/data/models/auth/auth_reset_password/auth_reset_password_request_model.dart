class AuthResetPasswordRequestModel {
  final String? email;

  AuthResetPasswordRequestModel({this.email});

  Map<String, dynamic> toJson() {
    return {if (email != null) 'email': email};
  }

  factory AuthResetPasswordRequestModel.fromJson(Map<String, dynamic> json) {
    return AuthResetPasswordRequestModel(email: json['email']);
  }
}
