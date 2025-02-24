import 'package:ascca_app/core/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/widgets/app_elevated_button.dart';
import '../../../core/widgets/app_text_form_field.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  // final AuthResetPasswordService authResetPasswordService =
  //     AuthResetPasswordService();

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
                    Align(
                      alignment: Alignment.center,
                      child: AppElevatedButton(
                        onPressed: () {
                          context.push(AppRoutes.verification.path);
                          // if (_formKey.currentState!.validate()) {
                          // authResetPasswordService.resetPassword(
                          //   context: context,
                          //   email: _emailController.text.trim(),
                          // );
                          // }
                        },
                        buttonColor: AppColors.lavenderBlue,
                        text: AppTexts.send,
                        textColor: AppColors.white,
                      ),
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
