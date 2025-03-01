enum AppRoutes {
  splash(path: '/splash'),
  onboarding(path: '/onboarding'),
  login(path: '/login'),
  register(path: '/register'),
  resetPassword(path: '/resetPassword'),
  verification(path: '/verification'),
  newPassword(path: '/newPassword'),
  home(path: '/home'),
  createEvent(path: '/createEvent'),
  notification(path: '/notification'),
  about(path: '/about'),
  bookmarkedEvents(path: '/bookmarkedEvents');

  const AppRoutes({required this.path});
  final String path;
}
