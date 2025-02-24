enum AppImages {
  splash(path: 'assets/images/splash.svg'),
  logo(path: 'assets/images/logo.svg'),
  google(path: 'assets/images/google.svg'),
  onboarding1(path: 'assets/images/onboarding1.svg'),
  onboarding2(path: 'assets/images/onboarding2.svg'),
  onboarding3(path: 'assets/images/onboarding3.svg');

  const AppImages({required this.path});
  final String path;
}
