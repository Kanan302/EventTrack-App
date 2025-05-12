import 'package:ascca_app/app/app.dart';
import 'package:ascca_app/shared/services/injection/di.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return App();
  }
}
