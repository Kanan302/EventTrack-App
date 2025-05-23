import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class GetEventsModel {
  final String? id;
  final String? name;
  final String? about;
  final String? startDate;
  final String? endDate;
  final String? imageURL;
  final String? city;
  final String? street;
  final String? lat;
  final String? lng;
  final double? price;
  final String? organizerName;
  final String? organizerId;

  GetEventsModel({
    this.id,
    this.name,
    this.about,
    this.startDate,
    this.endDate,
    this.imageURL,
    this.city,
    this.street,
    this.lat,
    this.lng,
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
      'imageURL': imageURL,
      'city': city,
      'street': street,
      'lat': lat,
      'lng': lng,
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
      imageURL: json['imageURL'],
      city: json['city'],
      street: json['street'],
      lat: json['lat'],
      lng: json['lng'],
      price: json['price']?.toDouble(),
      organizerId: json['organizerId']?.toString(),
      organizerName: json['organizerName'],
    );
  }
}
