import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/errors/flushbar.dart';
import '../../../core/errors/snackbar.dart';
import '../../../core/widgets/app_elevated_button.dart';
import '../../../core/widgets/app_text_form_field.dart';
import '../login/services/toggle_provider.dart';
import 'services/cubit/auth_new_password_service_cubit.dart';

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
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppTexts.newPassword,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Consumer<Toggle>(
                      builder: (context, visibilityProvider, child) {
                        return AppTextFormField(
                          obscureText: !visibilityProvider.isPasswordVisible,
                          hintText: AppTexts.yourNewPassword,
                          prefixIcon: Icons.lock_outline,
                          suffixIcon:
                              visibilityProvider.isPasswordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                          onPressed: visibilityProvider.toggleVisibility,
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Şifrənizi daxil edin';
                            } else if (value.length < 6) {
                              return 'Şifrə ən azı 6 simvoldan ibarət olmalıdır';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    Consumer<Toggle>(
                      builder: (context, visibilityProvider, child) {
                        return AppTextFormField(
                          obscureText: !visibilityProvider.isConfirmVisible,
                          hintText: AppTexts.confirmYourNewPassword,
                          prefixIcon: Icons.lock_outline,
                          suffixIcon:
                              visibilityProvider.isConfirmVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                          onPressed: visibilityProvider.toggleConfirm,
                          controller: _confirmPasswordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Şifrənizi daxil edin';
                            } else if (value.length < 6) {
                              return 'Şifrə ən azı 6 simvoldan ibarət olmalıdır';
                            }
                            return null;
                          },
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
                                    'Şifrələr uyğun gəlmir',
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
                            text: AppTexts.update,
                            textColor: AppColors.white,
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
