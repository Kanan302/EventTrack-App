class AuthNewPasswordRequestModel {
  final String? newPassword;
  final String? confirmPassword;

  AuthNewPasswordRequestModel({this.newPassword, this.confirmPassword});

  Map<String, dynamic> toJson() {
    return {
      if (newPassword != null) 'newPassword': newPassword,
      if (confirmPassword != null) 'confirmPassword': confirmPassword,
    };
  }

  factory AuthNewPasswordRequestModel.fromJson(Map<String, dynamic> json) {
    return AuthNewPasswordRequestModel(
      newPassword: json['newPassword'],
      confirmPassword: json['confirmPassword'],
    );
  }
}
