import 'package:ascca_app/cubits/auth_login/auth_login_cubit.dart';
import 'package:ascca_app/di.dart';
import 'package:ascca_app/views/home/create_event/pages/create_event.dart';
import 'package:ascca_app/views/home/profile_tab/pages/about/about.dart';
import 'package:ascca_app/views/home/profile_tab/pages/bookmarked_events/bookmarked_events.dart';
import 'package:ascca_app/views/home/profile_tab/pages/notifications/pages/notifications.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'core/utils/app_routes.dart';
import 'views/auth/login/pages/login.dart';
import 'views/auth/new_password/new_password.dart';
import 'cubits/auth_new_password/auth_new_password_cubit.dart';
import 'views/auth/register/pages/register.dart';
import 'cubits/auth_registration/auth_registration_cubit.dart';
import 'views/auth/reset_password/reset_password.dart';
import 'cubits/auth_reset_password/auth_reset_password_cubit.dart';
import 'views/onboarding/pages/onboarding.dart';
import 'views/splash/splash.dart';
import 'views/home/home.dart';

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
              create: (context) => getIt<AuthLoginCubit>(),
              child: const LoginPage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.register.path,
        builder:
            (context, state) => BlocProvider(
              create: (context) => getIt<AuthRegistrationCubit>(),
              child: const RegisterPage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.resetPassword.path,
        builder:
            (context, state) => BlocProvider(
              create: (context) => getIt<AuthResetPasswordCubit>(),
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
              create: (context) => getIt<AuthNewPasswordCubit>(),
              child: const NewPasswordPage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.home.path,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => getIt<AuthLoginCubit>(),
            child: HomePage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.createEvent.path,
        builder: (context, state) => CreateEventPage(),
      ),
      GoRoute(
        path: AppRoutes.bookmarkedEvents.path,
        builder: (context, state) => BookmarkedEventsPage(),
      ),
      GoRoute(
        path: AppRoutes.notification.path,
        builder: (context, state) => NotificationsPage(),
      ),
      GoRoute(
        path: AppRoutes.about.path,
        builder: (context, state) => AboutPage(),
      ),
    ],
  );
}
