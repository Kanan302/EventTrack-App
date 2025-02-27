import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/errors/flushbar.dart';
import '../../../../../core/errors/snackbar.dart';
import '../../../../../data/jwt/dio_configuration.dart';
import '../../../verification/presentation/pages/verification.dart';
import 'auth_registration_service_state.dart';

class AuthRegistrationCubit extends Cubit<AuthRegistrationState> {
  AuthRegistrationCubit() : super(AuthRegistrationInitial());

  Future<void> register({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    emit(AuthRegistrationLoading());

    try {
      final response = await baseDio.post(
        '/auth/register',
        data: {
          'fullName': fullName,
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
        },
      );

      if (response.statusCode == 200) {
        await _saveRegistrationData(fullName, email, password, confirmPassword);
        emit(AuthRegistrationSuccess());

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const VerificationPage(),
            settings: const RouteSettings(arguments: {'fromReset': false}),
          ),
        );

        SnackBarService.showSnackBar(
          context,
          'Qeydiyyat uğurlu oldu',
          AppColors.black,
        );
      } else {
        _handleError(context, 'Naməlum xəta baş verdi.');
      }
    } on DioException catch (e) {
      _handleDioError(e, context);
    } catch (e) {
      _handleError(context, 'Bilinməyən xəta baş verdi: $e');
    }
  }

  Future<void> _saveRegistrationData(
    String fullName,
    String email,
    String password,
    String confirmPassword,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('registerFullName', fullName);
    await prefs.setString('registerEmail', email);
    await prefs.setString('registerPassword', password);
    await prefs.setString('registerConfirmPassword', confirmPassword);
  }

  void _handleDioError(DioException e, BuildContext context) {
    final statusCode = e.response?.statusCode;
    final errorMessage = e.message ?? 'Bilinməyən xəta baş verdi.';

    if (statusCode == 404) {
      _handleError(context, 'Bu istifadəçi mövcuddur.');
    } else if (statusCode == 500) {
      _handleError(context, 'Sistemdə problem var, üzr istəyirik.');
    } else {
      _handleError(context, 'Xəta baş verdi: $errorMessage');
    }
  }

  void _handleError(BuildContext context, String message) {
    emit(AuthRegistrationFailure(message));
    FlushbarService.showFlushbar(
      context: context,
      message: message,
      isSuccess: false,
    );
    debugPrint(message);
  }
}
