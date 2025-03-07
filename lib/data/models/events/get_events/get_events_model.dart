import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class GetEventsModel {
  final String? id;
  final String? name;
  final String? about;
  final String? startDate;
  final String? endDate;
  final String? image;
  final String? location;
  final double? price;
  final String? organizerName;
  final String? organizerId;

  GetEventsModel({
    this.id,
    this.name,
    this.about,
    this.startDate,
    this.endDate,
    this.image,
    this.location,
    this.price,
    this.organizerName,
    this.organizerId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'about': about,
      'startDate': startDate,
      'endDate': endDate,
      'image': image,
      'location': location,
      'price': price,
      'organizerId': organizerId,
      'organizerName': organizerName,
    };
  }

  factory GetEventsModel.fromJson(Map<String, dynamic> json) {
    return GetEventsModel(
      id: json['id']?.toString(),
      name: json['name'],
      about: json['about'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      image: json['image'] ?? 'assets/images/international.svg',
      location: json['location'],
      price: json['price']?.toDouble(),
      organizerId: json['organizerId']?.toString(),
      organizerName: json['organizerName'],
    );
  }
}
