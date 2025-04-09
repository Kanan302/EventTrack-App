class UpdateProfileRequestModel {
  final String? fullName;
  final String? aboutMe;
  final String? profilePicture;

  UpdateProfileRequestModel({
    this.fullName,
    this.aboutMe,
    this.profilePicture,
  });

  Map<String, dynamic> toJson() {
    return {
      if (fullName != null) 'fullName': fullName,
      if (aboutMe != null) 'aboutMe': aboutMe,
      if (profilePicture != null) 'profilePicture': profilePicture,
    };
  }

  factory UpdateProfileRequestModel.fromJson(Map<String, dynamic> json) {
    return UpdateProfileRequestModel(
      fullName: json['fullName'],
      aboutMe: json['aboutMe'],
      profilePicture: json['profilePicture'],
    );
  }
}
