import 'package:ascca_app/repositories/auth_registration/auth_registration_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/app_colors.dart';
import '../../core/errors/flushbar.dart';
import '../../core/errors/snackbar.dart';
import '../../views/auth/verification/pages/verification.dart';
import 'auth_registration_state.dart';

class AuthRegistrationCubit extends Cubit<AuthRegistrationState> {
  final AuthRegistrationRepository repository;
  AuthRegistrationCubit({required this.repository})
    : super(AuthRegistrationInitial());

  Future<void> register({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    emit(AuthRegistrationLoading());

    try {
      await repository.register(fullName, email, password, confirmPassword);
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
    } catch (e) {
      _handleError(context, e.toString());
    }
  }

  void _handleError(BuildContext context, String message) {
    final cleanMessage = message.replaceFirst('Exception: ', '');

    emit(AuthRegistrationFailure(cleanMessage));
    FlushbarService.showFlushbar(
      context: context,
      message: message,
      isSuccess: false,
    );
    debugPrint(message);
  }
}
