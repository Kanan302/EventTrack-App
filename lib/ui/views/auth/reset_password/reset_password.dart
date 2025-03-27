import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/constants/app_texts.dart';
import '../../../utils/notifications/flushbar.dart';
import '../../../utils/widgets/app_elevated_button.dart';
import '../../../utils/widgets/app_text_form_field.dart';
import '../../../cubits/auth/auth_reset_password/auth_reset_password_cubit.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

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
                        AppTexts.resetPassword,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 300,
                      child: Text(
                        AppTexts.resetDescryption,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    AppTextFormField(
                      obscureText: false,
                      hintText: AppTexts.abc,
                      prefixIcon: Icons.email_outlined,
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'E-poçt ünvanınızı daxil edin';
                        } else if (!value.contains('@')) {
                          return 'E-poçt ünvanında "@" işarəsi olmalıdır';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.01),
                    BlocConsumer<
                      AuthResetPasswordCubit,
                      AuthResetPasswordState
                    >(
                      listener: (context, state) {
                        if (state is AuthResetPasswordLoading) {
                          CircularProgressIndicator();
                        } else if (state is AuthResetPasswordFailure) {
                          FlushbarService.showFlushbar(
                            context: context,
                            message: state.errorMessage,
                            isSuccess: false,
                          );
                        }
                      },
                      builder: (context, state) {
                        return Align(
                          alignment: Alignment.center,
                          child: AppElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context
                                    .read<AuthResetPasswordCubit>()
                                    .resetPassword(
                                      context: context,
                                      email: _emailController.text.trim(),
                                    );
                              }
                            },
                            buttonColor: AppColors.lavenderBlue,
                            text: AppTexts.send,
                            textColor: AppColors.white,
                            isLoading: state is AuthResetPasswordLoading,
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
