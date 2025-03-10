import 'package:ascca_app/data/repositories/events/bookmarked_events/bookmarked_events_repository.dart';
import 'package:ascca_app/data/repositories/events/create_event/create_event_repository.dart';
import 'package:ascca_app/data/repositories/events/get_events/get_events_repository.dart';
import 'package:ascca_app/data/repositories/profile/organizer/organizer_profile_repository.dart';
import 'package:ascca_app/data/services/events/events_api_client.dart';
import 'package:ascca_app/data/services/profile/profile_api_client.dart';
import 'package:ascca_app/shared/services/jwt/dio_configuration.dart';
import 'package:ascca_app/shared/services/local/secure_service.dart';
import 'package:ascca_app/ui/cubits/auth/auth_login/auth_login_cubit.dart';
import 'package:ascca_app/ui/cubits/auth/auth_new_password/auth_new_password_cubit.dart';
import 'package:ascca_app/ui/cubits/auth/auth_registration/auth_registration_cubit.dart';
import 'package:ascca_app/ui/cubits/auth/auth_reset_password/auth_reset_password_cubit.dart';
import 'package:ascca_app/data/repositories/auth/auth_login/auth_login_repository.dart';
import 'package:ascca_app/data/services/auth/auth_api_client.dart';
import 'package:ascca_app/data/repositories/auth/auth_new_password/auth_new_password_repository.dart';
import 'package:ascca_app/data/repositories/auth/auth_registration/auth_registration_repository.dart';
import 'package:ascca_app/data/repositories/auth/auth_reset_password/auth_reset_password_repository.dart';
import 'package:ascca_app/ui/cubits/events/bookmarked_events/bookmarked_events_cubit.dart';
import 'package:ascca_app/ui/cubits/events/create_event/create_event_cubit.dart';
import 'package:ascca_app/ui/cubits/events/get_events/get_events_cubit.dart';
import 'package:ascca_app/ui/cubits/profile/organizer/organizer_profile_cubit.dart';
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

  getIt.registerLazySingleton<EventsApiClient>(
    () => EventsApiClient(getIt<Dio>()),
  );

  getIt.registerLazySingleton<ProfileApiClient>(
    () => ProfileApiClient(getIt<Dio>()),
  );

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

  getIt.registerLazySingleton<GetEventsRepository>(
    () => GetEventsRepository(getIt<EventsApiClient>()),
  );

  getIt.registerLazySingleton<CreateEventRepository>(
    () => CreateEventRepository(getIt<EventsApiClient>()),
  );

  getIt.registerLazySingleton<BookmarkedEventsRepository>(
    () => BookmarkedEventsRepository(getIt<EventsApiClient>()),
  );

  getIt.registerLazySingleton<OrganizerProfileRepository>(
    () => OrganizerProfileRepository(getIt<ProfileApiClient>()),
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

  getIt.registerFactory<GetEventsCubit>(
    () => GetEventsCubit(repository: getIt<GetEventsRepository>()),
  );

  getIt.registerFactory<CreateEventCubit>(
    () => CreateEventCubit(
      secureService: getIt<SecureService>(),
      repository: getIt<CreateEventRepository>(),
    ),
  );

  getIt.registerFactory<BookmarkedEventsCubit>(
    () => BookmarkedEventsCubit(
      repository: getIt<BookmarkedEventsRepository>(),
      secureService: getIt<SecureService>(),
    ),
  );

  getIt.registerFactory<OrganizerProfileCubit>(
    () =>
        OrganizerProfileCubit(repository: getIt<OrganizerProfileRepository>()),
  );
}
