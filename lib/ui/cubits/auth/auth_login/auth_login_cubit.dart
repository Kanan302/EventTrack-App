import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../../data/models/auth/auth_login/auth_login_request_model.dart';
import '../../../../data/repositories/auth/auth_login/auth_login_repository.dart';
import '../../../../shared/constants/app_routes.dart';
import '../../../utils/notifications/flushbar.dart';
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

      await repository.login(authLoginRequestModel, context);
      emit(AuthLoginSuccess());

      if (context.mounted) {
        context.go(
          AppRoutes.home.path,
          extra: {
            'message': AppLocalizations.of(context).successLogin,
            'isSuccess': true,
          },
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
