import 'package:ascca_app/data/models/auth/auth_login/auth_login_request_model.dart';
import 'package:ascca_app/data/models/auth/auth_login/auth_login_response_model.dart';
import 'package:ascca_app/data/models/auth/auth_new_password/auth_new_password_request_model.dart';
import 'package:ascca_app/data/models/auth/auth_new_password/auth_new_password_response_model.dart';
import 'package:ascca_app/data/models/auth/auth_registration/auth_registration_request.dart';
import 'package:ascca_app/data/models/auth/auth_registration/auth_registration_response.dart';
import 'package:ascca_app/data/models/auth/auth_reset_password/auth_reset_password_request_model.dart';
import 'package:ascca_app/data/models/auth/auth_reset_password/auth_reset_password_response_model.dart';
import 'package:ascca_app/shared/constants/app_keys.dart';
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

  @POST("/auth/register")
  Future<AuthRegistrationResponseModel> register(
    @Body() AuthRegistrationRequestModel authRegistrationRequestModel,
  );

  @POST("/auth/requestPasswordReset")
  Future<AuthResetPasswordResponseModel> resetPassword(
    @Body() AuthResetPasswordRequestModel authResetPasswordRequestModel,
  );

  @POST("/auth/resetPassword")
  Future<AuthNewPasswordResponseModel> newPassword(
    @Body() AuthNewPasswordRequestModel authNewPasswordRequestModel,
  );
}

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
