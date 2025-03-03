class AuthModel {
  final String? fullName;
  final String? email;
  final String? password;
  final String? newPassword;
  final String? confirmPassword;

  AuthModel({
    this.fullName,
    this.email,
    this.password,
    this.newPassword,
    this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      if (fullName != null) 'fullName': fullName,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      if (newPassword != null) 'newPassword': newPassword,
      if (confirmPassword != null) 'confirmPassword': confirmPassword,
    };
  }

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      fullName: json['fullName'],
      email: json['email'],
      password: json['password'],
      newPassword: json['newPassword'],
      confirmPassword: json['confirmPassword'],
    );
  }
}
