import 'package:ascca_app/data/models/events/create_event/create_event_response_model.dart';
import 'package:ascca_app/data/models/events/get_events/get_events_model.dart';
import 'package:ascca_app/shared/constants/app_keys.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'events_api_client.g.dart';

@RestApi(baseUrl: AppKeys.baseUrl)
abstract class EventsApiClient {
  factory EventsApiClient(Dio dio, {String baseUrl}) = _EventsApiClient;

  @GET("/events")
  Future<List<GetEventsModel>> getEvents();

  @POST("/events")
  @MultiPart()
  Future<CreateEventResponseModel> createEvent(
    @Part(name: "name") String name,
    @Part(name: "about") String about,
    @Part(name: "location") String location,
    @Part(name: "startDate") String startDate,
    @Part(name: "endDate") String endDate,
    @Part(name: "organizerId") String organizerId,
  );
}
