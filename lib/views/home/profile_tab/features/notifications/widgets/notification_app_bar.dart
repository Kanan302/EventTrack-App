import 'package:ascca_app/core/utils/app_texts.dart';
import 'package:flutter/material.dart';

class NotificationAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const NotificationAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(AppTexts.notifications),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
