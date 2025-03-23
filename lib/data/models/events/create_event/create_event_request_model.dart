import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CreateEventRequestModel {
  final String? name;
  final String? about;
  final String? city;
  final String? street;
  final String? imageURL;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? organizerId;

  CreateEventRequestModel({
    this.name,
    this.about,
    this.city,
    this.street,
    this.imageURL,
    this.startDate,
    this.endDate,
    this.organizerId,
  });

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (about != null) 'about': about,
      if (city != null) 'city': city,
      if (street != null) 'street': street,
      if (imageURL != null) 'imageURL': imageURL,
      if (startDate != null) 'startDate': startDate!.toIso8601String(),
      if (endDate != null) 'endDate': endDate!.toIso8601String(),
      if (organizerId != null) 'organizerId': organizerId,
    };
  }

  factory CreateEventRequestModel.fromJson(Map<String, dynamic> json) {
    return CreateEventRequestModel(
      name: json['name'],
      about: json['about'],
      city: json['city'],
      street: json['street'],
      imageURL: json['imageURL'],
      startDate:
          json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      organizerId: json['organizerId'],
    );
  }
}
