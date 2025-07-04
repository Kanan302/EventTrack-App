import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/events/bookmarked_events/bookmarked_events_model.dart';
import '../../../data/models/events/get_events/get_events_model.dart';
import '../../../data/models/events/top_events/top_events_model.dart';
import '../../../generated/l10n/app_localizations.dart';
import '../../../ui/cubits/auth/auth_login/auth_login_cubit.dart';
import '../../../ui/cubits/auth/auth_new_password/auth_new_password_cubit.dart';
import '../../../ui/cubits/auth/auth_registration/auth_registration_cubit.dart';
import '../../../ui/cubits/auth/auth_reset_password/auth_reset_password_cubit.dart';
import '../../../ui/cubits/events/bookmarked_events/delete_bookmarked_event.dart/delete_bookmarked_events_cubit.dart';
import '../../../ui/cubits/events/bookmarked_events/get_bookmarked_events/bookmarked_events_cubit.dart';
import '../../../ui/cubits/events/bookmarked_events/post_bookmark_event/bookmark_events_cubit.dart';
import '../../../ui/cubits/events/create_event/create_event_cubit.dart';
import '../../../ui/cubits/events/delete_event/delete_event_cubit.dart';
import '../../../ui/cubits/events/export_event/export_event_cubit.dart';
import '../../../ui/cubits/events/get_events/get_events_cubit.dart';
import '../../../ui/cubits/events/register_event/register_event_cubit.dart';
import '../../../ui/cubits/events/scan_event/scan_event_cubit.dart';
import '../../../ui/cubits/events/top_events/top_events_cubit.dart';
import '../../../ui/cubits/profile/organizer/organizer_profile_cubit.dart';
import '../../../ui/cubits/profile/update_profile/update_profile_cubit.dart';
import '../../../ui/cubits/profile/user/user_profile_cubit.dart';
import '../../../ui/views/auth/login/pages/login.dart';
import '../../../ui/views/auth/new_password/new_password.dart';
import '../../../ui/views/auth/register/pages/register.dart';
import '../../../ui/views/auth/reset_password/reset_password.dart';
import '../../../ui/views/home/create_event/pages/create_event.dart';
import '../../../ui/views/home/event_detail/pages/event_detail.dart';
import '../../../ui/views/home/home.dart';
import '../../../ui/views/home/notifications/pages/notifications.dart';
import '../../../ui/views/home/organizer/pages/organizer.dart';
import '../../../ui/views/home/profile_tab/pages/bookmarked_events/bookmarked_events.dart';
import '../../../ui/views/home/profile_tab/pages/do_scan/do_scan.dart';
import '../../../ui/views/home/profile_tab/pages/my_events/my_events.dart';
import '../../../ui/views/home/profile_tab/pages/update_profile/update_profile.dart';
import '../../../ui/views/onboarding/pages/onboarding.dart';
import '../../../ui/views/splash/splash.dart';
import '../../constants/app_routes.dart';
import '../injection/di.dart';

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
              BlocProvider(create: (context) => getIt<UserProfileCubit>()),
              BlocProvider(create: (context) => getIt<DeleteEventCubit>()),
              BlocProvider(create: (context) => getIt<TopEventsCubit>()),
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
        builder:
            (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => getIt<BookmarkedEventsCubit>(),
                ),
                BlocProvider(create: (context) => getIt<DeleteEventCubit>()),
              ],
              child: BookmarkedEventsPage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.notification.path,
        builder: (context, state) => NotificationsPage(),
      ),
      GoRoute(
        path: AppRoutes.eventDetails.path,
        builder: (context, state) {
          final eventModel = state.extra;

          if (eventModel is GetEventsModel ||
              eventModel is BookmarkedEventsModel ||
              eventModel is TopEventsModel) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => getIt<OrganizerProfileCubit>(),
                ),
                BlocProvider(create: (context) => getIt<BookmarkEventsCubit>()),
                BlocProvider(
                  create: (context) => getIt<DeleteBookmarkedEventsCubit>(),
                ),
                BlocProvider(create: (context) => getIt<RegisterEventCubit>()),
                BlocProvider(create: (context) => getIt<ExportEventCubit>()),
              ],
              child: EventDetailPage(eventModel: eventModel),
            );
          }
          return Scaffold(
            body: Center(child: Text(AppLocalizations.of(context).wrongModel)),
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
      GoRoute(
        path: AppRoutes.updateProfile.path,
        builder:
            (context, state) => BlocProvider(
              create: (context) => getIt<UpdateProfileCubit>(),
              child: UpdateProfilePage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.doScan.path,
        builder:
            (context, state) => BlocProvider(
              create: (context) => getIt<ScanEventCubit>(),
              child: DoScanPage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.myEvents.path,
        builder:
            (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => getIt<OrganizerProfileCubit>(),
                ),
                BlocProvider(create: (context) => getIt<DeleteEventCubit>()),
              ],
              child: MyEventsPage(),
            ),
      ),
    ],
  );
}
