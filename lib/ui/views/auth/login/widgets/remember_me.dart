import 'package:flutter/material.dart';

import '../../../../../generated/l10n/app_localizations.dart';
import '../../../../../shared/theme/app_colors.dart';
import '../services/remember_me_notifier.dart';

class RememberMe extends StatefulWidget {
  final RememberMeNotifier rememberMeNotifier;

  const RememberMe({super.key, required this.rememberMeNotifier});

  @override
  State<RememberMe> createState() => _RememberMeState();
}

class _RememberMeState extends State<RememberMe> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.rememberMeNotifier,
      builder: (context, isRememberMe, child) {
        return Row(
          children: [
            Transform.scale(
              scale: 0.8,
              child: Switch(
                value: !isRememberMe,
                onChanged: (value) {
                  widget.rememberMeNotifier.toggleRemember();
                },
                activeColor: AppColors.lavenderBlue,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            Text(
              AppLocalizations.of(context).rememberMe,
              style: TextStyle(fontSize: 15),
            ),
          ],
        );
      },
    );
  }
}
