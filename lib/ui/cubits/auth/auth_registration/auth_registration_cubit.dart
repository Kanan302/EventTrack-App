import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/auth/auth_registration/auth_registration_request.dart';
import '../../../../data/repositories/auth/auth_registration/auth_registration_repository.dart';
import '../../../../generated/l10n/app_localizations.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../utils/notifications/flushbar.dart';
import '../../../utils/notifications/snackbar.dart';
import '../../../views/auth/verification/pages/verification.dart';
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
      AuthRegistrationRequestModel authRegisterRequestModel =
          AuthRegistrationRequestModel(
            fullName: fullName,
            email: email,
            password: password,
            confirmPassword: confirmPassword,
          );

      await repository.register(authRegisterRequestModel, context);
      emit(AuthRegistrationSuccess());

      final isDarkMode = Theme.of(context).brightness == Brightness.dark;
      final snackBarColor = isDarkMode ? AppColors.white : AppColors.black;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const VerificationPage(),
          settings: const RouteSettings(arguments: {'fromReset': false}),
        ),
      );
      SnackBarService.showSnackBar(
        context,
        AppLocalizations.of(context).registrationSuccessfully,
        snackBarColor,
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
      message: cleanMessage,
      isSuccess: false,
    );
    debugPrint(cleanMessage);
  }
}
