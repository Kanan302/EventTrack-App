import 'package:ascca_app/models/auth_model.dart';
import 'package:ascca_app/repositories/auth_reset_password/auth_reset_password_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/errors/flushbar.dart';
import '../../views/auth/verification/pages/verification.dart';

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
      AuthModel model = AuthModel(email: email);
      await repository.resetPassword(model);
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
