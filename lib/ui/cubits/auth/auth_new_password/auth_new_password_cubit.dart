import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../data/models/auth/auth_new_password/auth_new_password_request_model.dart';
import '../../../../data/repositories/auth/auth_new_password/auth_new_password_repository.dart';
import '../../../../generated/l10n/app_localizations.dart';
import '../../../../shared/constants/app_routes.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../utils/notifications/flushbar.dart';
import '../../../utils/notifications/snackbar.dart';

part 'auth_new_password_state.dart';

class AuthNewPasswordCubit extends Cubit<AuthNewPasswordState> {
  final AuthNewPasswordRepository repository;

  AuthNewPasswordCubit({required this.repository})
    : super(AuthNewPasswordInitial());

  Future<void> newPassword({
    required BuildContext context,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(AuthNewPasswordLoading());

    try {
      AuthNewPasswordRequestModel authNewPasswordRequestModel =
          AuthNewPasswordRequestModel(
            newPassword: newPassword,
            confirmPassword: confirmPassword,
          );

      await repository.newPassword(authNewPasswordRequestModel, context);
      emit(AuthNewPasswordSuccess());

      final isDarkMode = Theme.of(context).brightness == Brightness.dark;
      final snackBarColor = isDarkMode ? AppColors.white : AppColors.black;

      SnackBarService.showSnackBar(
        context,
        AppLocalizations.of(context).passwordsUpdated,
        snackBarColor,
      );

      context.go(AppRoutes.login.path);
    } catch (e) {
      _handleError(context, e.toString());
    }
  }

  void _handleError(BuildContext context, String message) {
    final cleanMessage = message.replaceFirst('Exception: ', '');

    emit(AuthNewPasswordFailure(cleanMessage));
    FlushbarService.showFlushbar(
      context: context,
      message: message,
      isSuccess: false,
    );
    debugPrint(message);
  }
}
