import 'package:ascca_app/shared/constants/app_keys.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CreateEventResponseModel {
  final int? id;
  final String? name;
  final String? about;
  final String? city;
  final String? street;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? organizerId;
  final String? organizerName;
  final int? price;
  final String? imageURL;

  CreateEventResponseModel({
    this.id,
    this.name,
    this.about,
    this.city,
    this.street,
    this.startDate,
    this.endDate,
    this.organizerId,
    this.organizerName,
    this.price,
    this.imageURL,
  });

  Map<String, dynamic> toJson() {
    return {
      AppKeys.response: {
        AppKeys.data: {
          'id': id,
          if (name != null) 'name': name,
          if (about != null) 'about': about,
          if (city != null) 'city': city,
          if (street != null) 'street': street,
          if (startDate != null) 'startDate': startDate!.toIso8601String(),
          if (endDate != null) 'endDate': endDate!.toIso8601String(),
          if (organizerId != null) 'organizerId': organizerId,
          if (organizerName != null) 'organizerName': organizerName,
          if (price != null) 'price': price,
          if (imageURL != null) 'imageURL': imageURL,
        },
      },
    };
  }

  factory CreateEventResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json[AppKeys.response][AppKeys.data];
    return CreateEventResponseModel(
      id: data['id'] as int?,
      name: data['name'] as String?,
      about: data['about'] as String?,      
      city: data['city'] as String?,
      street: data['street'] as String?,
      startDate:
          data['startDate'] != null ? DateTime.parse(data['startDate']) : null,
      endDate: data['endDate'] != null ? DateTime.parse(data['endDate']) : null,
      organizerId: data['organizerId']?.toString(),
      organizerName: data['organizerName'] as String?,
      price: data['price'] as int?,
      imageURL: data['imageURL'] as String?,
    );
  }
}
