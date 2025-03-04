import 'package:ascca_app/shared/services/jwt/dio_configuration.dart';
import 'package:ascca_app/shared/services/local/secure_service.dart';
import 'package:ascca_app/ui/cubits/auth/auth_login/auth_login_cubit.dart';
import 'package:ascca_app/ui/cubits/auth/auth_new_password/auth_new_password_cubit.dart';
import 'package:ascca_app/ui/cubits/auth/auth_registration/auth_registration_cubit.dart';
import 'package:ascca_app/ui/cubits/auth/auth_reset_password/auth_reset_password_cubit.dart';
import 'package:ascca_app/data/repositories/auth/auth_login/auth_login_repository.dart';
import 'package:ascca_app/data/services/auth_api_client.dart';
import 'package:ascca_app/data/repositories/auth/auth_new_password/auth_new_password_repository.dart';
import 'package:ascca_app/data/repositories/auth/auth_registration/auth_registration_repository.dart';
import 'package:ascca_app/data/repositories/auth/auth_reset_password/auth_reset_password_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Secure Storage
  getIt.registerLazySingleton(
    () => SecureService(secureStorage: const FlutterSecureStorage()),
  );

  // Dio Configuration
  getIt.registerLazySingleton(() => baseDio);

  // Retrofit (API Client)
  getIt.registerLazySingleton<AuthApiClient>(() => AuthApiClient(getIt<Dio>()));

  // Repository
  getIt.registerLazySingleton<AuthLoginRepository>(
    () => AuthLoginRepository(getIt<SecureService>(), getIt<AuthApiClient>()),
  );

  getIt.registerLazySingleton<AuthRegistrationRepository>(
    () => AuthRegistrationRepository(getIt<AuthApiClient>()),
  );

  getIt.registerLazySingleton<AuthResetPasswordRepository>(
    () => AuthResetPasswordRepository(getIt<AuthApiClient>()),
  );

  getIt.registerLazySingleton<AuthNewPasswordRepository>(
    () => AuthNewPasswordRepository(getIt<AuthApiClient>()),
  );

  // Cubit
  getIt.registerFactory<AuthLoginCubit>(
    () => AuthLoginCubit(repository: getIt<AuthLoginRepository>()),
  );

  getIt.registerFactory<AuthRegistrationCubit>(
    () =>
        AuthRegistrationCubit(repository: getIt<AuthRegistrationRepository>()),
  );

  getIt.registerFactory<AuthResetPasswordCubit>(
    () => AuthResetPasswordCubit(
      repository: getIt<AuthResetPasswordRepository>(),
    ),
  );

  getIt.registerFactory<AuthNewPasswordCubit>(
    () => AuthNewPasswordCubit(repository: getIt<AuthNewPasswordRepository>()),
  );
}
