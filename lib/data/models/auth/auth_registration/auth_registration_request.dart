class AuthRegistrationRequestModel {
  final String? fullName;
  final String? email;
  final String? password;
  final String? confirmPassword;

  AuthRegistrationRequestModel({
    this.fullName,
    this.email,
    this.password,
    this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      if (fullName != null) 'fullName': fullName,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      if (confirmPassword != null) 'confirmPassword': confirmPassword,
    };
  }

  factory AuthRegistrationRequestModel.fromJson(Map<String, dynamic> json) {
    return AuthRegistrationRequestModel(
      fullName: json['fullName'],
      email: json['email'],
      password: json['password'],
      confirmPassword: json['confirmPassword'],
    );
  }
}
