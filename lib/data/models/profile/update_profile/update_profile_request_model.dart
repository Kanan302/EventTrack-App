class UpdateProfileRequestModel {
  final String? fullName;
  final String? aboutMe;
  final String? profilePicture;

  UpdateProfileRequestModel({this.fullName, this.aboutMe, this.profilePicture});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (fullName != null) data['fullName'] = fullName;
    if (aboutMe != null) data['aboutMe'] = aboutMe;
    if (profilePicture != null) data['profilePicture'] = profilePicture;
    return data;
  }

  factory UpdateProfileRequestModel.fromJson(Map<String, dynamic> json) {
    return UpdateProfileRequestModel(
      fullName: json['fullName'],
      aboutMe: json['aboutMe'],
      profilePicture: json['profilePicture'],
    );
  }
}
