class UserProfileModel {
  final String? id;
  final String? fullName;
  final String? profilePictureUrl;
  final String? aboutMe;

  const UserProfileModel({
    this.id,
    this.fullName,
    this.profilePictureUrl,
    this.aboutMe,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'profilePictureUrl': profilePictureUrl,
      'aboutMe': aboutMe,
    };
  }

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id']?.toString(),
      fullName: json['fullName'],
      profilePictureUrl: json['profilePictureUrl'],
      aboutMe: json['aboutMe'],
    );
  }
}
