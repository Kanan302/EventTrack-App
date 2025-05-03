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
    final controllers = List.generate(4, (_) => TextEditingController());

    return Form(
      key: formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(4, (index) {
          return VerificationTextField(
            controller: controllers[index],
            onChanged: (value) {
              if (value.length == 1 && index < 3) {
                FocusScope.of(context).nextFocus();
              } else if (value.isEmpty && index > 0) {
                FocusScope.of(context).previousFocus();
              }
            },
            onSaved: (_) {
              if (index == 3) {
                final otp = controllers.map((c) => c.text).join();
                onSavedOtp(otp);
              }
            },
            validator: Validators.isEmpty,
          );
        }),
      ),
    );
  }
}
