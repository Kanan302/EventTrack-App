import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../shared/constants/app_images.dart';
import '../../../../../shared/theme/app_colors.dart';
import '../../../../cubits/auth/auth_registration/auth_registration_cubit.dart';
import '../../../../cubits/auth/auth_registration/auth_registration_state.dart';
import '../../../../utils/notifications/snackbar.dart';
import '../../../../utils/validators/validators.dart';
import '../../../../utils/widgets/app_elevated_button.dart';
import '../../../../utils/widgets/app_text_form_field.dart';
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context).signUp,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    AppTextFormField(
                      obscureText: false,
                      hintText: AppLocalizations.of(context).fullName,
                      prefixIcon: Icons.person_2_outlined,
                      controller: _fullNameController,
                      validator:
                          (value) => Validators.writeName(value, context),
                    ),
                    AppTextFormField(
                      obscureText: false,
                      hintText: AppLocalizations.of(context).abc,
                      prefixIcon: Icons.email_outlined,
                      controller: _emailController,
                      validator:
                          (value) => Validators.writeMail(value, context),
                    ),
                    ValueListenableBuilder(
                      valueListenable: _isPasswordVisible,
                      builder: (context, isVisible, child) {
                        return AppTextFormField(
                          obscureText: !isVisible,
                          hintText: AppLocalizations.of(context).yourPassword,
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
                              AppLocalizations.of(context).confirmPassword,
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
                    SizedBox(height: height * 0.001),
                    BlocBuilder<AuthRegistrationCubit, AuthRegistrationState>(
                      builder: (context, state) {
                        return AppElevatedButton(
                          onPressed:
                              state is AuthRegistrationLoading
                                  ? () {}
                                  : () {
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
                                      } else {
                                        context
                                            .read<AuthRegistrationCubit>()
                                            .register(
                                              fullName:
                                                  _fullNameController.text,
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text,
                                              confirmPassword:
                                                  _confirmPasswordController
                                                      .text,
                                              context: context,
                                            );
                                      }
                                    }
                                  },
                          buttonColor: AppColors.lavenderBlue,
                          text: AppLocalizations.of(context).signUpUppercase,
                          textColor: AppColors.white,
                          isLoading: state is AuthRegistrationLoading,
                        );
                      },
                    ),

                    Text(
                      AppLocalizations.of(context).or,
                      style: TextStyle(color: AppColors.softGray, fontSize: 16),
                    ),
                    AppElevatedButton(
                      icon: SvgPicture.asset(
                        AppImages.google.path,
                        width: 24,
                        height: 24,
                      ),
                      onPressed: () {},
                      buttonColor: AppColors.white,
                      text: AppLocalizations.of(context).loginWithGoogle,
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
    );
  }
}
