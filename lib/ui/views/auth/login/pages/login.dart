import 'package:ascca_app/shared/constants/app_images.dart';
import 'package:ascca_app/ui/cubits/auth/auth_login/auth_login_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../shared/theme/app_colors.dart';
import '../../../../../shared/constants/app_routes.dart';
import '../../../../../shared/constants/app_texts.dart';
import '../../../../utils/widgets/app_elevated_button.dart';
import '../../../../utils/widgets/app_text_form_field.dart';
import '../../../../cubits/auth/auth_login/auth_login_state.dart';

import '../services/remember_me_notifier.dart';
import '../widgets/navigation_sign_up.dart';
import '../widgets/remember_me.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier<bool>(false);
  final RememberMeNotifier _rememberMeNotifier = RememberMeNotifier();

  void _handleLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthLoginCubit>().login(
        email: _emailController.text,
        password: _passwordController.text,
        context: context,
      );
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      _emailController.text = 'alizadekanan6@gmail.com';
      _passwordController.text = 'password123';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: height * 0.02),
                SvgPicture.asset(AppImages.logo.path),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      spacing: height * 0.02,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppTexts.signIn,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        AppTextFormField(
                          obscureText: false,
                          hintText: AppTexts.abc,
                          prefixIcon: Icons.email_outlined,
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Mail daxil edin';
                            } else if (!value.contains('@')) {
                              return 'Mailda @ simvolu yoxdur';
                            }
                            return null;
                          },
                        ),

                        ValueListenableBuilder<bool>(
                          valueListenable: _isPasswordVisible,
                          builder: (context, isVisible, child) {
                            return AppTextFormField(
                              obscureText: !isVisible,
                              hintText: AppTexts.yourPassword,
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Parol daxil edin';
                                } else if (value.length < 6) {
                                  return 'Parol ən azı 6 simvol uzunluğunda olmalıdır';
                                }
                                return null;
                              },
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RememberMe(rememberMeNotifier: _rememberMeNotifier),
                            GestureDetector(
                              onTap:
                                  () => context.push(
                                    AppRoutes.resetPassword.path,
                                  ),
                              child: const Text(
                                AppTexts.forgotPassword,
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.001),
                        BlocBuilder<AuthLoginCubit, AuthLoginState>(
                          builder: (context, state) {
                            return AppElevatedButton(
                              onPressed:
                                  state is AuthLoginLoading
                                      ? () {}
                                      : () => _handleLogin(context),
                              buttonColor: AppColors.lavenderBlue,
                              text: AppTexts.signInUppercase,
                              textColor: AppColors.white,
                              isLoading: state is AuthLoginLoading,
                            );
                          },
                        ),
                        const Text(
                          AppTexts.or,
                          style: TextStyle(
                            color: AppColors.softGray,
                            fontSize: 16,
                          ),
                        ),
                        AppElevatedButton(
                          icon: SvgPicture.asset(
                            AppImages.google.path,
                            width: 24,
                            height: 24,
                          ),
                          onPressed: () {},
                          buttonColor: AppColors.white,
                          text: AppTexts.loginWithGoogle,
                          textColor: AppColors.black,
                        ),
                        const NavigationSignUp(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _rememberMeNotifier.dispose();
    super.dispose();
  }
}
