import 'package:ascca_app/core/errors/flushbar.dart';
import 'package:ascca_app/models/auth_model.dart';
import 'package:ascca_app/repositories/auth_login/auth_login_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_keys.dart';
import '../../../../../core/utils/app_routes.dart';
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
      AuthModel model = AuthModel(email: email, password: password);
      await repository.loginUser(model);
      emit(AuthLoginSuccess());

      debugPrint('Message: ${AppKeys.message}');

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
