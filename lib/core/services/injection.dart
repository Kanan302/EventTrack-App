import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'local/secure_service.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerLazySingleton(
    () => SecureService(secureStorage: const FlutterSecureStorage()),
  );
}