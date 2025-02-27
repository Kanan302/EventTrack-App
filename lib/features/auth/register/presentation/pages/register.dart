import 'package:ascca_app/core/constants/app_images.dart';
import 'package:ascca_app/core/errors/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_texts.dart';
import '../../../../../core/errors/snackbar.dart';
import '../../../../../core/widgets/app_elevated_button.dart';
import '../../../../../core/widgets/app_text_form_field.dart';
import '../../../login/services/toggle_provider.dart';
import '../../services/cubit/auth_registration_service_cubit.dart';
import '../../services/cubit/auth_registration_service_state.dart';
import '../widgets/navigation_sign_in.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => AuthRegistrationCubit(),
      child: ChangeNotifierProvider(
        create: (_) => Toggle(),
        child: Scaffold(
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppTexts.signUp,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        AppTextFormField(
                          obscureText: false,
                          hintText: AppTexts.fullName,
                          prefixIcon: Icons.person_2_outlined,
                          controller: _fullNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Adınızı daxil edin';
                            }
                            return null;
                          },
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
                        Consumer<Toggle>(
                          builder: (context, visibilityProvider, child) {
                            return AppTextFormField(
                              obscureText:
                                  !visibilityProvider.isPasswordVisible,
                              hintText: AppTexts.yourPassword,
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
                              hintText: AppTexts.confirmPassword,
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
                        SizedBox(height: height * 0.001),
                        BlocConsumer<
                          AuthRegistrationCubit,
                          AuthRegistrationState
                        >(
                          listener: (context, state) {
                            if (state is AuthRegistrationFailure) {
                              FlushbarService.showFlushbar(
                                context: context,
                                message: state.errorMessage,
                                isSuccess: false,
                              );
                            }
                          },
                          builder: (context, state) {
                            return AppElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (_passwordController.text !=
                                      _confirmPasswordController.text) {
                                    SnackBarService.showSnackBar(
                                      context,
                                      'Şifrələr uyğun gəlmir',
                                      AppColors.red,
                                    );
                                  } else {
                                    context
                                        .read<AuthRegistrationCubit>()
                                        .register(
                                          fullName: _fullNameController.text,
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                          confirmPassword:
                                              _confirmPasswordController.text,
                                          context: context,
                                        );
                                  }
                                }
                              },
                              buttonColor: AppColors.lavenderBlue,
                              text: AppTexts.signUpUppercase,
                              textColor: AppColors.white,
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

                        const NavigationSignIn(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
