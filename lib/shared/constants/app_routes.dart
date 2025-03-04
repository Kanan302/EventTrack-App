enum AppRoutes {
  splash('/splash'),
  onboarding('/onboarding'),
  login('/login'),
  register('/register'),
  resetPassword('/resetPassword'),
  verification('/verification'),
  newPassword('/newPassword'),
  home('/home'),
  createEvent('/createEvent'),
  notification('/notification'),
  about('/about'),
  bookmarkedEvents('/bookmarkedEvents');

  const AppRoutes(this.path);
  final String path;
}
