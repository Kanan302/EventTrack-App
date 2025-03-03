// import 'package:dio/dio.dart';

// class AuthApiClient {
//   final Dio dio;

//   AuthApiClient({required this.dio});

//   Future<bool> login(String mail, String password) async {
//     await dio.post('path', data: model.toJson());
//     return Future(() => true,);
//   }

//   Future<bool> register(String name, String surname) {
//     return Future.delayed(Duration.zero);
//   }

//   Future<bool> logout() {
//     return Future.delayed(Duration.zero);
//   }
// }

import 'package:ascca_app/data/models/auth_login/auth_login_request_model.dart';
import 'package:ascca_app/data/models/auth_login/auth_login_response_model.dart';
import 'package:ascca_app/shared/utils/app_keys.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'auth_api_client.g.dart';

@RestApi(baseUrl: AppKeys.baseUrl)
abstract class AuthApiClient {
  factory AuthApiClient(Dio dio, {String baseUrl}) = _AuthApiClient;

  @POST("/auth/login")
  Future<AuthLoginResponseModel> login(
    @Body() AuthLoginRequestModel authLoginRequestModel,
  );
}
