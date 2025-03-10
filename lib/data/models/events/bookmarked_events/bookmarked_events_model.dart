import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class BookmarkedEventsModel {
  final int eventId;

  const BookmarkedEventsModel({required this.eventId});

  Map<String, dynamic> toJson() {
    return {'eventId': eventId};
  }

  factory BookmarkedEventsModel.fromJson(Map<String, dynamic> json) {
    return BookmarkedEventsModel(eventId: json['eventId'] as int);
  }
}
