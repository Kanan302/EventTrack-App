import 'package:ascca_app/data/models/auth/auth_login/auth_login_request_model.dart';
import 'package:ascca_app/ui/utils/messages/messages.dart';
import 'package:ascca_app/ui/utils/notifications/flushbar.dart';
import 'package:ascca_app/data/repositories/auth/auth_login/auth_login_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/constants/app_routes.dart';
import 'auth_login_state.dart';

class AuthLoginCubit extends Cubit<AuthLoginState> {
  final AuthLoginRepository repository;

  AuthLoginCubit({required this.repository}) : super(AuthLoginInitial());

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    emit(AuthLoginLoading());

    try {
      AuthLoginRequestModel authLoginRequestModel = AuthLoginRequestModel(
        email: email,
        password: password,
      );

      await repository.login(authLoginRequestModel);
      emit(AuthLoginSuccess());

      if (context.mounted) {
        context.go(
          AppRoutes.home.path,
          extra: {'message': Messages.successLogin, 'isSuccess': true},
        );
      }
    } catch (e) {
      _handleError(context, e.toString());
    }
  }

  void _handleError(BuildContext context, String message) {
    final cleanMessage = message.replaceFirst('Exception: ', '');

    emit(AuthLoginFailure(cleanMessage));

    FlushbarService.showFlushbar(
      context: context,
      message: cleanMessage,
      isSuccess: false,
    );
    debugPrint(cleanMessage);
  }
}
