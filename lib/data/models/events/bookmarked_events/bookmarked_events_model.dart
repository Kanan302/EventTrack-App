import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class BookmarkedEventsModel {
  final String? id;
  final String? name;
  final String? about;
  final String? startDate;
  final String? endDate;
  final String? imageURL;
  final String? city;
  final String? street;
  final double? price;
  final String? organizerName;
  final String? organizerId;

  const BookmarkedEventsModel({
    this.id,
    this.name,
    this.about,
    this.startDate,
    this.endDate,
    this.imageURL,
    this.city,
    this.street,
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
      'price': price,
      'organizerId': organizerId,
      'organizerName': organizerName,
    };
  }

  factory BookmarkedEventsModel.fromJson(Map<String, dynamic> json) {
    return BookmarkedEventsModel(
      id: json['id']?.toString(),
      name: json['name'],
      about: json['about'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      imageURL: json['imageURL'],
      city: json['city'],
      street: json['street'],
      price: json['price']?.toDouble(),
      organizerId: json['organizerId']?.toString(),
      organizerName: json['organizerName'],
    );
  }
}
