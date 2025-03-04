import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../constants/app_keys.dart';

abstract interface class ISecureService {
  Future<void> saveAccessToken(String value);
  Future<void> saveRefreshToken(String value);
  Future<void> saveUserId(String value);
  Future<void> saveUserStatus(String value);

  Future<String?> get accessToken;
  Future<String?> get refreshToken;
  Future<String?> get userId;
  Future<String?> get userStatus;

  Future<void> clearToken();
}

class SecureService implements ISecureService {
  final FlutterSecureStorage secureStorage;
  SecureService({required this.secureStorage});

  @override
  Future<void> saveAccessToken(String value) async {
    try {
      await secureStorage.write(key: AppKeys.accessToken, value: value);
    } catch (e, s) {
      Error.throwWithStackTrace(e, s);
    }
  }

  @override
  Future<void> saveRefreshToken(String value) async {
    try {
      await secureStorage.write(key: AppKeys.refreshToken, value: value);
    } catch (e, s) {
      Error.throwWithStackTrace(e, s);
    }
  }

  @override
  Future<void> saveUserId(String value) async {
    try {
      await secureStorage.write(key: AppKeys.userId, value: value);
    } catch (e, s) {
      Error.throwWithStackTrace(e, s);
    }
  }

  @override
  Future<void> saveUserStatus(String value) async {
    try {
      await secureStorage.write(key: AppKeys.status, value: value);
    } catch (e, s) {
      Error.throwWithStackTrace(e, s);
    }
  }

  @override
  Future<String?> get accessToken async {
    try {
      return await secureStorage.read(key: AppKeys.accessToken);
    } catch (e, s) {
      Error.throwWithStackTrace(e, s);
    }
  }

  @override
  Future<String?> get refreshToken async {
    try {
      return await secureStorage.read(key: AppKeys.refreshToken);
    } catch (e, s) {
      Error.throwWithStackTrace(e, s);
    }
  }

  @override
  Future<String?> get userId async {
    try {
      return await secureStorage.read(key: AppKeys.userId);
    } catch (e, s) {
      Error.throwWithStackTrace(e, s);
    }
  }

  @override
  Future<String?> get userStatus async {
    try {
      return await secureStorage.read(key: AppKeys.status);
    } catch (e, s) {
      Error.throwWithStackTrace(e, s);
    }
  }

  @override
  Future<void> clearToken() async {
    try {
      await secureStorage.delete(key: AppKeys.accessToken);
      await secureStorage.delete(key: AppKeys.refreshToken);
      await secureStorage.delete(key: AppKeys.userId);
      await secureStorage.delete(key: AppKeys.status);
    } catch (e, s) {
      Error.throwWithStackTrace(e, s);
    }
  }
}
