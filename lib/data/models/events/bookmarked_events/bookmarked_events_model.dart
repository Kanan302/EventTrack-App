import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class BookmarkedEventsModel {
  final String? id;
  final String? name;
  final String? about;
  final String? startDate;
  final String? endDate;
  final String? imageURL;
  final String? location;
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
      'imageURL': imageURL,
      'location': location,
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
      location: json['location'],
      price: json['price']?.toDouble(),
      organizerId: json['organizerId']?.toString(),
      organizerName: json['organizerName'],
    );
  }
}
