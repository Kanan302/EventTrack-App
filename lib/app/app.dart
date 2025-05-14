import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../generated/l10n/app_localizations.dart';
import '../shared/l10n/l10n.dart';
import '../shared/services/navigation/app_router.dart';
import '../ui/views/home/profile_tab/service/locale_cubit.dart';
import '../ui/views/home/profile_tab/service/theme_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final isSystemDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) {
            final themeCubit = ThemeCubit();
            themeCubit.setSystemTheme(
              isSystemDarkMode ? Brightness.dark : Brightness.light,
            );
            return themeCubit;
          },
        ),
        BlocProvider(create: (context) => LocaleCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return BlocBuilder<LocaleCubit, Locale>(
            builder: (context, locale) {
              return MaterialApp.router(
                title: 'GoEvent',
                locale: locale,
                supportedLocales: L10n.all,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  DefaultCupertinoLocalizations.delegate,
                  DefaultMaterialLocalizations.delegate,
                  DefaultWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                theme: ThemeData.light(),
                darkTheme: ThemeData.dark(),
                themeMode: themeMode,
                routerConfig: AppRouter.router,
              );
            },
          );
        },
      ),
    );
  }
}
