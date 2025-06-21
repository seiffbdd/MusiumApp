import 'package:flutter/material.dart';
import 'package:musium/config/routes/app_router.dart';
import 'package:musium/config/theme/app_theme.dart';
import 'package:musium/core/utils/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
