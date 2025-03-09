import 'package:ascca_app/data/models/events/get_events/get_events_model.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class OrganizerProfileModel {
  final String? id;
  final String? fullName;
  final String? profilePictureUrl;
  final String? aboutMe;
  final List<GetEventsModel>? events;

  OrganizerProfileModel({
    this.id,
    this.fullName,
    this.profilePictureUrl,
    this.aboutMe,
    this.events,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'profilePictureUrl': profilePictureUrl,
      'aboutMe': aboutMe,
      'events': events?.map((e) => e.toJson()).toList(),
    };
  }

  factory OrganizerProfileModel.fromJson(Map<String, dynamic> json) {
    return OrganizerProfileModel(
      id: json['id']?.toString(),
      fullName: json['fullName'],
      profilePictureUrl: json['profilePictureUrl'],
      aboutMe: json['aboutMe'],
      events:
          (json['events'] as List<dynamic>?)
              ?.map((e) => GetEventsModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }
}
