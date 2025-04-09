class TopEventsModel {
  int? id;
  String? name;
  String? about;
  String? startDate;
  String? endDate;
  String? imageURL;
  String? street;
  String? city;
  int? organizerId;
  int? registrationCount;

  TopEventsModel({
    this.id,
    this.name,
    this.about,
    this.startDate,
    this.endDate,
    this.imageURL,
    this.street,
    this.city,
    this.organizerId,
    this.registrationCount,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'about': about,
      'startDate': startDate,
      'endDate': endDate,
      'imageURL': imageURL,
      'street': street,
      'city': city,
      'organizerId': organizerId,
      'registrationCount': registrationCount,
    };
  }

  factory TopEventsModel.fromJson(Map<String, dynamic> json) {
    return TopEventsModel(
      id: json['id'],
      name: json['name'],
      about: json['about'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      imageURL: json['imageURL'],
      street: json['street'],
      city: json['city'],
      organizerId: json['organizerId'],
      registrationCount: json['registrationCount'],
    );
  }
}
