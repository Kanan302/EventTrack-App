import 'package:ascca_app/ui/views/home/profile_tab/service/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/services/navigation/app_router.dart';

class VApp extends StatelessWidget {
  const VApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isSystemDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return BlocProvider(
      create: (_) {
        final themeCubit = ThemeCubit();
        themeCubit.setSystemTheme(
          isSystemDarkMode ? Brightness.dark : Brightness.light,
        );
        return themeCubit;
      },
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            title: 'Go Event',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeMode,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
