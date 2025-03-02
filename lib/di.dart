import 'package:ascca_app/core/services/local/secure_service.dart';
import 'package:ascca_app/cubits/auth_reset_password/auth_reset_password_cubit.dart';
import 'package:ascca_app/repositories/auth_reset_password/auth_reset_password_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Secure Storage üçün service qeydiyyatı
  getIt.registerLazySingleton(
    () => SecureService(secureStorage: const FlutterSecureStorage()),
  );

  // Repository qeydiyyatı
  getIt.registerLazySingleton<AuthResetPasswordRepository>(
    () => AuthResetPasswordRepository(),
  );

  // Cubit qeydiyyatı
  getIt.registerFactory<AuthResetPasswordCubit>(
    () => AuthResetPasswordCubit(
      repository: getIt<AuthResetPasswordRepository>(),
    ),
  );
}
