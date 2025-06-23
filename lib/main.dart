import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:musium/config/routes/app_router.dart';
import 'package:musium/config/theme/app_theme.dart';
import 'package:musium/core/utils/service_locator.dart';
import 'package:musium/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(context),
      routerConfig: AppRouter.router,
    );
  }
}
