import 'package:ascca_app/data/models/events/get_events/get_events_model.dart';
import 'package:ascca_app/shared/constants/app_routes.dart';
import 'package:ascca_app/ui/cubits/auth/auth_login/auth_login_cubit.dart';
import 'package:ascca_app/shared/services/injection/di.dart';
import 'package:ascca_app/ui/cubits/auth/auth_new_password/auth_new_password_cubit.dart';
import 'package:ascca_app/ui/cubits/auth/auth_registration/auth_registration_cubit.dart';
import 'package:ascca_app/ui/cubits/auth/auth_reset_password/auth_reset_password_cubit.dart';
import 'package:ascca_app/ui/cubits/events/create_event/create_event_cubit.dart';
import 'package:ascca_app/ui/cubits/events/get_events/get_events_cubit.dart';
import 'package:ascca_app/ui/cubits/profile/organizer/organizer_profile_cubit.dart';
import 'package:ascca_app/ui/views/auth/login/pages/login.dart';
import 'package:ascca_app/ui/views/auth/new_password/new_password.dart';
import 'package:ascca_app/ui/views/auth/register/pages/register.dart';
import 'package:ascca_app/ui/views/auth/reset_password/reset_password.dart';
import 'package:ascca_app/ui/views/home/create_event/pages/create_event.dart';
import 'package:ascca_app/ui/views/home/event_detail/pages/event_detail.dart';
import 'package:ascca_app/ui/views/home/home.dart';
import 'package:ascca_app/ui/views/home/organizer/pages/organizer.dart';
import 'package:ascca_app/ui/views/home/profile_tab/pages/bookmarked_events/bookmarked_events.dart';
import 'package:ascca_app/ui/views/home/profile_tab/pages/notifications/pages/notifications.dart';
import 'package:ascca_app/ui/views/onboarding/pages/onboarding.dart';
import 'package:ascca_app/ui/views/splash/splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<AuthLoginCubit>()),
              BlocProvider(create: (context) => getIt<GetEventsCubit>()),
            ],
            child: HomePage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.createEvent.path,
        builder:
            (context, state) => BlocProvider(
              create: (context) => getIt<CreateEventCubit>(),
              child: CreateEventPage(),
            ),
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
        path: AppRoutes.eventDetails.path,
        builder: (context, state) {
          final eventModel = state.extra as GetEventsModel;
          return BlocProvider(
            create: (context) => getIt<OrganizerProfileCubit>(),
            child: EventDetailPage(eventModel: eventModel),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.organizer.path,
        builder: (context, state) {
          final organizerId = state.extra as int? ?? 0;
          return BlocProvider(
            create: (context) => getIt<OrganizerProfileCubit>(),
            child: OrganizerPage(organizerId: organizerId),
          );
        },
      ),
    ],
  );
}
