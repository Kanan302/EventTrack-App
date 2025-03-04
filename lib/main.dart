import 'package:flutter/material.dart';

import 'ui/utils/navigation/app_router.dart';
import 'shared/services/injection/di.dart';

Future<void> main() async {
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ASCCA App',
      routerConfig: AppRouter.router,
    );
  }
}
