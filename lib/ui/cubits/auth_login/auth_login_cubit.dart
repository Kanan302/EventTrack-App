import 'package:ascca_app/data/models/auth_login/auth_login_request_model.dart';
import 'package:ascca_app/ui/utils/flushbar.dart';
import 'package:ascca_app/data/repositories/auth_login/auth_login_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/utils/app_routes.dart';
import 'auth_login_state.dart';

class AuthLoginCubit extends Cubit<AuthLoginState> {
  final AuthLoginRepository repository;

  AuthLoginCubit({required this.repository}) : super(AuthLoginInitial());

  Future<void> loginUser({
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
      await repository.loginUser(authLoginRequestModel);
      emit(AuthLoginSuccess());

      // debugPrint('Message: ${'message'}');

      if (context.mounted) {
        context.go(
          AppRoutes.home.path,
          extra: {'message': 'Daxil olma uğurlu oldu', 'isSuccess': true},
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
