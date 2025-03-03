import 'package:ascca_app/shared/utils/app_images.dart';
import 'package:ascca_app/shared/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/services/local/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SharedPreferenceService _sharedPrefService = SharedPreferenceService();

  Future<void> _navigateBasedOnRememberMe() async {
    bool isRememberMe = await _sharedPrefService.readRememberMe();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        if (isRememberMe) {
          context.go(AppRoutes.onboarding.path);
        } else {
          context.go(AppRoutes.home.path);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigateBasedOnRememberMe();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SvgPicture.asset(AppImages.splash.path, width: 250),
        ),
      ),
    );
  }
}
