import 'package:ascca_app/data/models/profile/organizer/organizer_profile_model.dart';
import 'package:ascca_app/data/models/profile/user/user_profile_model.dart';
import 'package:ascca_app/shared/constants/app_keys.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'profile_api_client.g.dart';

@RestApi(baseUrl: AppKeys.baseUrl)
abstract class ProfileApiClient {
  factory ProfileApiClient(Dio dio, {String baseUrl}) = _ProfileApiClient;

  @GET("/profiles/organizer/{id}")
  Future<OrganizerProfileModel> getOrganizerData(@Path("id") int organizerId);

  @GET("/profiles/{id}")
  Future<UserProfileModel> getUserData(@Path("id") int userId);
}
