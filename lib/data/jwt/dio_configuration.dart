import 'package:dio/dio.dart';
import '../../core/constants/app_keys.dart';
import 'jwt_interceptor.dart';

final baseDio =
    Dio()
      ..options = BaseOptions(
        baseUrl: AppKeys.baseUrl,
        contentType: 'application/json',
        // connectTimeout: const Duration(seconds: 6),
        // receiveTimeout: const Duration(seconds: 12),
      )
      ..interceptors.add(JwtInterceptor());
