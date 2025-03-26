import 'dart:io';
import 'package:json_annotation/json_annotation.dart';

part 'create_event_request_model.g.dart';

@JsonSerializable()
class CreateEventRequestModel {
  final String? name;
  final String? about;
  final String? city;
  final String? street;
  @JsonKey(ignore: true) 
  final File? image;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? organizerId;

  CreateEventRequestModel({
    this.name,
    this.about,
    this.city,
    this.street,
    this.image,
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
      if (image != null) 'image': image,
      if (startDate != null) 'startDate': startDate!.toIso8601String(),
      if (endDate != null) 'endDate': endDate!.toIso8601String(),
      if (organizerId != null) 'organizerId': organizerId,
    };
  }

  // factory CreateEventRequestModel.fromJson(Map<String, dynamic> json) {
  //   return CreateEventRequestModel(
  //     name: json['name'],
  //     about: json['about'],
  //     city: json['city'],
  //     street: json['street'],
  //     image: json['image'],
  //     startDate:
  //         json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
  //     endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
  //     organizerId: json['organizerId'],
  //   );
  // }

  factory CreateEventRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CreateEventRequestModelFromJson(json);
}
