import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CreateEventRequestModel {
  final String? name;
  final String? about;
  final String? location;
  final String? imageURL;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? organizerId;

  CreateEventRequestModel({
    this.name,
    this.about,
    this.location,
    this.imageURL,
    this.startDate,
    this.endDate,
    this.organizerId,
  });

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (about != null) 'about': about,
      if (location != null) 'location': location,
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
      location: json['location'],
      imageURL: json['imageURL'],
      startDate:
          json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      organizerId: json['organizerId'],
    );
  }
}
