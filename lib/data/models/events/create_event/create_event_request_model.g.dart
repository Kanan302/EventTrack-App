// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_event_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateEventRequestModel _$CreateEventRequestModelFromJson(
  Map<String, dynamic> json,
) => CreateEventRequestModel(
  name: json['name'] as String?,
  about: json['about'] as String?,
  city: json['city'] as String?,
  street: json['street'] as String?,
  lat: json['lat'] as String?,
  lng: json['lng'] as String?,
  startDate:
      json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
  endDate:
      json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
  organizerId: json['organizerId'] as String?,
);

Map<String, dynamic> _$CreateEventRequestModelToJson(
  CreateEventRequestModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'about': instance.about,
  'city': instance.city,
  'street': instance.street,
  'lat': instance.lat,
  'lng': instance.lng,
  'startDate': instance.startDate?.toIso8601String(),
  'endDate': instance.endDate?.toIso8601String(),
  'organizerId': instance.organizerId,
};
