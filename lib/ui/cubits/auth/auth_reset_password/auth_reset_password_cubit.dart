import 'package:ascca_app/data/models/auth/auth_reset_password/auth_reset_password_request_model.dart';
import 'package:ascca_app/data/repositories/auth/auth_reset_password/auth_reset_password_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/notifications/flushbar.dart';
import '../../../views/auth/verification/pages/verification.dart';

part 'auth_reset_password_state.dart';

class AuthResetPasswordCubit extends Cubit<AuthResetPasswordState> {
  final AuthResetPasswordRepository repository;

  AuthResetPasswordCubit({required this.repository})
    : super(AuthResetPasswordInitial());

  Future<void> resetPassword({
    required BuildContext context,
    required String email,
  }) async {
    emit(AuthResetPasswordLoading());

    try {
      AuthResetPasswordRequestModel authResetPasswordRequestModel =
          AuthResetPasswordRequestModel(email: email);

      await repository.resetPassword(authResetPasswordRequestModel);
      emit(AuthResetPasswordSuccess());

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const VerificationPage(),
          settings: const RouteSettings(arguments: {'fromReset': true}),
        ),
      );
    } catch (e) {
      _handleError(context, e.toString());
    }
  }

  void _handleError(BuildContext context, String message) {
    final cleanMessage = message.replaceFirst('Exception: ', '');

    emit(AuthResetPasswordFailure(cleanMessage));

    FlushbarService.showFlushbar(
      context: context,
      message: cleanMessage,
      isSuccess: false,
    );
    debugPrint(cleanMessage);
  }
}
