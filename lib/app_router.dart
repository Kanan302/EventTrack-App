import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_routes.dart';
import 'data/local/secure_service.dart';
import 'features/auth/login/presentation/pages/login.dart';
import 'features/auth/login/services/cubit/auth_login_cubit.dart';
import 'features/auth/login/services/toggle_provider.dart';
import 'features/auth/newPassword/new_password.dart';
import 'features/auth/register/presentation/pages/register.dart';
import 'features/auth/register/services/cubit/auth_registration_service_cubit.dart';
import 'features/auth/resetPassword/reset_password.dart';
import 'features/onboarding/presentation/pages/onboarding.dart';
import 'features/onboarding/services/onboarding_provider.dart';
import 'features/splash/splash.dart';
import 'features/home/home.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash.path,
    routes: [
      GoRoute(
        path: AppRoutes.splash.path,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.onboarding.path,
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (_) => OnboardingProvider(),
              child: const OnboardingPage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.login.path,
        builder:
            (context, state) => MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => Toggle()),
                BlocProvider(
                  create:
                      (context) => AuthLoginCubit(
                        secureStorage: SecureService(
                          secureStorage: const FlutterSecureStorage(),
                        ),
                      ),
                ),
              ],
              child: const LoginPage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.register.path,
        builder:
            (context, state) => MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => Toggle()),
                BlocProvider(create: (context) => AuthRegistrationCubit()),
              ],
              child: const RegisterPage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.resetPassword.path,
        builder: (context, state) => const ResetPasswordPage(),
      ),
      // GoRoute(
      //   path: AppRoutes.verification.path,
      //   builder: (context, state) {
      //     final args = state.extra as Map<String, dynamic>?;
      //     final fromReset = args?['fromReset'] ?? false;

      //     return BlocProvider(
      //       create: (context) => AuthVerificationCubit(),
      //       child: VerificationPage(fromReset: fromReset),
      //     );
      //   },
      // ),
      GoRoute(
        path: AppRoutes.newPassword.path,
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (_) => Toggle(),
              child: const NewPasswordPage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.home.path,
        builder: (context, state) {
          return MultiProvider(
            providers: [
              BlocProvider(
                create:
                    (context) => AuthLoginCubit(
                      secureStorage: SecureService(
                        secureStorage: const FlutterSecureStorage(),
                      ),
                    ),
              ),
            ],
            child: HomePage(),
          );
        },
      ),
    ],
  );
}
