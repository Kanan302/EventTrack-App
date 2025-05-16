import 'package:flutter/material.dart';

import '../../../../../generated/l10n/app_localizations.dart';
import '../../../../../shared/theme/app_colors.dart';
import '../../../../utils/widgets/app_elevated_button.dart';

class EventDetailButtonAdminDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const EventDetailButtonAdminDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        AppLocalizations.of(context).export,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: Text(
        AppLocalizations.of(context).confirmExport,
        style: TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        Row(
          children: [
            Expanded(
              child: AppElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                buttonColor: AppColors.white,
                text: AppLocalizations.of(context).no,
                textColor: AppColors.lavenderBlue,
                borderColor: AppColors.lavenderBlue,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: AppElevatedButton(
                onPressed: onConfirm,
                buttonColor: AppColors.lavenderBlue,
                text: AppLocalizations.of(context).yes,
                textColor: AppColors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
