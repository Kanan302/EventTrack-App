import 'package:ascca_app/features/home/create_event/presentation/pages/create_event.dart';
import 'package:ascca_app/features/home/profile_tab/features/about/about.dart';
import 'package:ascca_app/features/home/profile_tab/features/bookmarked_events/bookmarked_events.dart';
import 'package:ascca_app/features/home/profile_tab/features/notifications/presentation/pages/notifications.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

import 'core/constants/app_routes.dart';
import 'data/local/secure_service.dart';
import 'features/auth/login/presentation/pages/login.dart';
import 'features/auth/login/services/cubit/auth_login_cubit.dart';
import 'features/auth/new_password/new_password.dart';
import 'features/auth/new_password/services/cubit/auth_new_password_service_cubit.dart';
import 'features/auth/register/presentation/pages/register.dart';
import 'features/auth/register/services/cubit/auth_registration_service_cubit.dart';
import 'features/auth/reset_password/reset_password.dart';
import 'features/auth/reset_password/services/cubit/auth_reset_password_service_cubit.dart';
import 'features/onboarding/presentation/pages/onboarding.dart';
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
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: AppRoutes.login.path,
        builder:
            (context, state) => BlocProvider(
              create:
                  (context) => AuthLoginCubit(
                    secureStorage: SecureService(
                      secureStorage: const FlutterSecureStorage(),
                    ),
                  ),
              child: const LoginPage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.register.path,
        builder:
            (context, state) => BlocProvider(
              create: (context) => AuthRegistrationCubit(),
              child: const RegisterPage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.resetPassword.path,
        builder:
            (context, state) => BlocProvider(
              create: (context) => AuthResetPasswordCubit(),
              child: const ResetPasswordPage(),
            ),
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
            (context, state) => BlocProvider(
              create: (context) => AuthNewPasswordCubit(),
              child: const NewPasswordPage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.home.path,
        builder: (context, state) {
          return BlocProvider(
            create:
                (context) => AuthLoginCubit(
                  secureStorage: SecureService(
                    secureStorage: const FlutterSecureStorage(),
                  ),
                ),
            child: HomePage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.createEvent.path,
        builder: (context, state) => CreateEventPage(),
      ),
      GoRoute(
        path: AppRoutes.notification.path,
        builder: (context, state) => NotificationsPage(),
      ),
     
      GoRoute(
        path: AppRoutes.about.path,
        builder: (context, state) => AboutPage(),
      ),
      GoRoute(
        path: AppRoutes.bookmarkedEvents.path,
        builder: (context, state) => BookmarkedEventsPage(),
      ),
    ],
  );
}
