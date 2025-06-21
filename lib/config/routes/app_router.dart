import 'package:go_router/go_router.dart';
import 'package:musium/features/welcome/presentation/pages/welcome_page.dart';

/// A centralized class to manage the application's route configuration.
abstract class AppRouter {
  static const welcomePageName = 'splashPage';
  static const welcomePagePath = '/';

  /// The main router configuration using `go_router`.
  static final router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        name: welcomePageName,
        path: welcomePagePath,
        builder: (context, state) => WelcomePage(),
      ),
    ],
  );
}
