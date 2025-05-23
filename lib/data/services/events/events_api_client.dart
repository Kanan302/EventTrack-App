import 'package:ascca_app/data/models/events/bookmarked_events/bookmarked_events_model.dart';
import 'package:ascca_app/data/models/events/create_event/create_event_response_model.dart';
import 'package:ascca_app/data/models/events/delete_event/delete_event_model.dart';
import 'package:ascca_app/data/models/events/export_event/export_event_response_model.dart';
import 'package:ascca_app/data/models/events/get_events/get_events_model.dart';
import 'package:ascca_app/data/models/events/register_event/register_event_response_model.dart';
import 'package:ascca_app/data/models/events/scan_event/scan_event_response_model.dart';
import 'package:ascca_app/data/models/events/top_events/top_events_model.dart';
import 'package:ascca_app/shared/constants/app_keys.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../models/events/scan_event/scan_event_request_model.dart';

part 'events_api_client.g.dart';

@RestApi(baseUrl: AppKeys.baseUrl)
abstract class EventsApiClient {
  factory EventsApiClient(Dio dio, {String baseUrl}) = _EventsApiClient;

  @GET("/events")
  Future<List<GetEventsModel>> getEvents();

  @POST("/events")
  @MultiPart()
  Future<CreateEventResponseModel> createEvent(
    // @Part(name: "name") String name,
    // @Part(name: "about") String about,
    // @Part(name: "city") String city,
    // @Part(name: "street") String street,
    // @Part(name: "image") MultipartFile image,
    // @Part(name: "startDate") String startDate,
    // @Part(name: "endDate") String endDate,
    // @Part(name: "organizerId") String organizerId,
    @Body() FormData formData,
  );

  @GET("/bookmarks/{id}")
  Future<List<BookmarkedEventsModel>> getBookmarkedEvents(
    @Path("id") int userId,
  );

  @POST("/bookmarks/{userId}/{eventId}")
  Future<String> bookmarkEvent(
    @Path("userId") String userId,
    @Path("eventId") String eventId,
  );

  @DELETE("/bookmarks/{userId}/{eventId}")
  Future<String> deleteBookmarkEvent(
    @Path("userId") String userId,
    @Path("eventId") String eventId,
  );

  @DELETE("/events/{eventId}")
  Future<DeleteEventModel> deleteEvent(@Path("eventId") String eventId);

  @POST("/events/register/{userId}/{eventId}")
  Future<RegisterEventResponseModel> registerEvent(
    @Path("userId") String userId,
    @Path("eventId") String eventId,
  );

  @GET("/events/top5")
  Future<List<TopEventsModel>> getTopEvents();

  @POST("/events/qrScan")
  Future<ScanEventResponseModel> scanEvent(
    @Body() ScanEventRequestModel request,
  );

  @GET("/events/export/{userId}/{eventId}")
  Future<ExportEventResponseModel> exportEvent(
    @Path("userId") String userId,
    @Path("eventId") String eventId,
  );
}
