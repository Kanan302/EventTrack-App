import 'package:ascca_app/shared/constants/app_keys.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CreateEventResponseModel {
  final int? id;
  final String? name;
  final String? about;
  final String? location;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? organizerId;
  final String? organizerName;
  final int? price;
  final String? imageUrl;

  CreateEventResponseModel({
    this.id,
    this.name,
    this.about,
    this.location,
    this.startDate,
    this.endDate,
    this.organizerId,
    this.organizerName,
    this.price,
    this.imageUrl,
  });

  factory CreateEventResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json[AppKeys.response][AppKeys.data];
    return CreateEventResponseModel(
      id: data['id'] as int?,
      name: data['name'] as String?,
      about: data['about'] as String?,
      location: data['location'] as String?,
      startDate:
          data['startDate'] != null ? DateTime.parse(data['startDate']) : null,
      endDate: data['endDate'] != null ? DateTime.parse(data['endDate']) : null,
      organizerId: data['organizerId']?.toString(),
      organizerName: data['organizerName'] as String?,
      price: data['price'] as int?,
      imageUrl: data['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppKeys.response: {
        AppKeys.data: {
          'id': id,
          if (name != null) 'name': name,
          if (about != null) 'about': about,
          if (location != null) 'location': location,
          if (startDate != null) 'startDate': startDate!.toIso8601String(),
          if (endDate != null) 'endDate': endDate!.toIso8601String(),
          if (organizerId != null) 'organizerId': organizerId,
          if (organizerName != null) 'organizerName': organizerName,
          if (price != null) 'price': price,
          if (imageUrl != null) 'imageUrl': imageUrl,
        },
      },
    };
  }
}
