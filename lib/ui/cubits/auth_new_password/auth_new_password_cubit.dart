import 'package:ascca_app/data/models/auth_model.dart';
import 'package:ascca_app/data/repositories/auth_new_password/auth_new_password_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/theme/app_colors.dart';
import '../../../shared/utils/app_routes.dart';
import '../../utils/flushbar.dart';
import '../../utils/snackbar.dart';

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
      AuthModel model = AuthModel(
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      await repository.newPassword(model);
      emit(AuthNewPasswordSuccess());

      SnackBarService.showSnackBar(
        context,
        'Şifrə uğurla yeniləndi!',
        AppColors.black,
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
