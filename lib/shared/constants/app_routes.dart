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
  bookmarkedEvents('/bookmarkedEvents'),
  eventDetails('/eventDetails'),
  organizer('/organizer'),
  updateProfile('/updateProfile');

  const AppRoutes(this.path);

  final String path;
}
