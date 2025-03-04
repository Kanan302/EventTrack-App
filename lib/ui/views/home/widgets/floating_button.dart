import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/constants/app_routes.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(useMaterial3: false),
      child: FloatingActionButton(
        backgroundColor: AppColors.lavenderBlue,
        onPressed: () => context.push(AppRoutes.createEvent.path),
        child: const Icon(Icons.add_box, size: 25),
      ),
    );
  }
}
