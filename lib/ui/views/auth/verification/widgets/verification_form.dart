import 'package:ascca_app/ui/utils/validators/validators.dart';
import 'package:flutter/material.dart';

import 'verification_formfield.dart';

class VerificationForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Function(String) onSavedOtp;

  const VerificationForm({
    super.key,
    required this.formKey,
    required this.onSavedOtp,
  });

  @override
  Widget build(BuildContext context) {
    String otp = '';

    return Form(
      key: formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          VerificationTextField(
            onChanged: (value) {
              if (value.length == 1) {
                otp += value;
                FocusScope.of(context).nextFocus();
              } else if (value.isEmpty) {
                FocusScope.of(context).previousFocus();
              }
            },
            onSaved: (pin1) {},
            validator: Validators.isEmpty,
          ),
          VerificationTextField(
            onChanged: (value) {
              if (value.length == 1) {
                otp += value;
                FocusScope.of(context).nextFocus();
              } else if (value.isEmpty) {
                FocusScope.of(context).previousFocus();
              }
            },
            onSaved: (pin2) {},
            validator: Validators.isEmpty,
          ),
          VerificationTextField(
            onChanged: (value) {
              if (value.length == 1) {
                otp += value;
                FocusScope.of(context).nextFocus();
              } else if (value.isEmpty) {
                FocusScope.of(context).previousFocus();
              }
            },
            onSaved: (pin3) {},
            validator: Validators.isEmpty,
          ),
          VerificationTextField(
            onChanged: (value) {
              if (value.length == 1) {
                otp += value;
                FocusScope.of(context).nextFocus();
              } else if (value.isEmpty) {
                FocusScope.of(context).previousFocus();
              }
            },
            onSaved: (pin4) {
              onSavedOtp(otp);
            },
            validator: Validators.isEmpty,
          ),
        ],
      ),
    );
  }
}
