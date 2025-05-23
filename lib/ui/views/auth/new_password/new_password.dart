import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n/app_localizations.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../cubits/auth/auth_new_password/auth_new_password_cubit.dart';
import '../../../utils/notifications/flushbar.dart';
import '../../../utils/notifications/snackbar.dart';
import '../../../utils/validators/validators.dart';
import '../../../utils/widgets/app_elevated_button.dart';
import '../../../utils/widgets/app_text_form_field.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isConfirmPasswordVisible = ValueNotifier<bool>(
    false,
  );

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 20.0,
                left: 20.0,
                right: 20.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: height * 0.02,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context).newPassword,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    ValueListenableBuilder(
                      valueListenable: _isPasswordVisible,
                      builder: (context, isVisible, child) {
                        return AppTextFormField(
                          obscureText: !isVisible,
                          hintText:
                              AppLocalizations.of(context).yourNewPassword,
                          prefixIcon: Icons.lock_outline,
                          suffixIcon:
                              isVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                          onPressed: () {
                            _isPasswordVisible.value =
                                !_isPasswordVisible.value;
                          },
                          controller: _passwordController,
                          validator:
                              (value) =>
                                  Validators.writePassword(value, context),
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: _isConfirmPasswordVisible,
                      builder: (context, isConfirmVisible, child) {
                        return AppTextFormField(
                          obscureText: !isConfirmVisible,
                          hintText:
                              AppLocalizations.of(
                                context,
                              ).confirmYourNewPassword,
                          prefixIcon: Icons.lock_outline,
                          suffixIcon:
                              isConfirmVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                          onPressed: () {
                            _isConfirmPasswordVisible.value =
                                !_isConfirmPasswordVisible.value;
                          },
                          controller: _confirmPasswordController,
                          validator:
                              (value) =>
                                  Validators.writePassword(value, context),
                        );
                      },
                    ),
                    SizedBox(height: height * 0.01),
                    BlocConsumer<AuthNewPasswordCubit, AuthNewPasswordState>(
                      listener: (context, state) {
                        if (state is AuthNewPasswordLoading) {
                          CircularProgressIndicator();
                        } else if (state is AuthNewPasswordFailure) {
                          FlushbarService.showFlushbar(
                            context: context,
                            message: state.errorMessage,
                            isSuccess: false,
                          );
                        }
                      },
                      builder: (context, state) {
                        return Center(
                          child: AppElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (_passwordController.text !=
                                    _confirmPasswordController.text) {
                                  SnackBarService.showSnackBar(
                                    context,
                                    AppLocalizations.of(
                                      context,
                                    ).passwordsDoNotMatch,
                                    AppColors.red,
                                  );
                                  return;
                                }
                                context
                                    .read<AuthNewPasswordCubit>()
                                    .newPassword(
                                      context: context,
                                      newPassword: _passwordController.text,
                                      confirmPassword:
                                          _confirmPasswordController.text,
                                    );
                              }
                            },
                            buttonColor: AppColors.lavenderBlue,
                            text: AppLocalizations.of(context).update,
                            textColor: AppColors.white,
                            isLoading: state is AuthNewPasswordLoading,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
