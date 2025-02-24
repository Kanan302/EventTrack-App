enum AppRoutes {
  splash(path: '/splash'),
  onboarding(path: '/onboarding'),
  login(path: '/login'),
  register(path: '/register'),
  resetPassword(path: '/resetPassword'),
  verification(path: '/verification'),
  newPassword(path: '/newPassword'),
  home(path: '/home');

  const AppRoutes({required this.path});
  final String path;
}
