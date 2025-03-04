import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../../../../shared/theme/app_colors.dart';
import '../../../../../shared/constants/app_routes.dart';
import '../../../../../shared/constants/app_texts.dart';
import '../../../../utils/notifications/snackbar.dart';
import '../../../../widgets/app_elevated_button.dart';
import '../services/auth_verification.dart';
import '../widgets/validity_time.dart';
import '../widgets/verification_form.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthVerificationService _authService = AuthVerificationService();
  String _otp = '';
  bool _isWaitingForOTP = false;

  Future<void> _handleVerification(bool fromReset) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_isWaitingForOTP) {
        bool tempResponse = await _authService.verification(
          otp: _otp,
          context: context,
        );
        if (!tempResponse) {
          SnackBarService.showSnackBar(
            context,
            'Xahiş edirik, yanlış OTP daxil etdiyiniz üçün 30 saniyə gözləyin.',
            AppColors.red,
          );
          return;
        } else {
          setState(() {
            _isWaitingForOTP = false;
            _otp = '';
          });
        }
      }

      bool response;
      if (fromReset) {
        response = await _authService.verificationForResetPassword(
          otp: _otp,
          context: context,
        );
      } else {
        response = await _authService.verification(otp: _otp, context: context);
      }

      if (response) {
        if (fromReset) {
          context.push(AppRoutes.newPassword.path);
        } else {
          context.go(AppRoutes.login.path);
        }
      } else {
        setState(() {
          _isWaitingForOTP = true;
          _otp = '';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final fromReset = args?['fromReset'] ?? false;

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppTexts.verification,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  const SizedBox(
                    width: 250,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: AppTexts.sendOTP,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          TextSpan(
                            text: ' abc@gmail.com',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.lavenderBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.035),
                  VerificationForm(
                    formKey: _formKey,
                    onSavedOtp: (otp) {
                      _otp = otp;
                    },
                  ),
                  SizedBox(height: height * 0.04),
                  Center(
                    child: AppElevatedButton(
                      onPressed: () => _handleVerification(fromReset),
                      buttonColor: AppColors.lavenderBlue,
                      text: AppTexts.contine,
                      textColor: AppColors.white,
                    ),
                  ),
                  SizedBox(height: height * 0.04),
                  const Center(child: ValidityTimer()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
