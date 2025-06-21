import 'package:go_router/go_router.dart';
import 'package:musium/core/storage/cache_helper.dart';
import 'package:musium/core/utils/service_locator.dart';
import 'package:musium/features/auth/presentation/pages/login_page.dart';
import 'package:musium/features/welcome/presentation/pages/welcome_page.dart';

/// A centralized class to manage the application's route configuration.
abstract class AppRouter {
  static const welcomePageName = 'welcomePage';
  static const welcomePagePath = '/';

  static const loginPageName = 'loginPage';
  static const loginPagePath = '/loginPage';

  /// The main router configuration using `go_router`.
  static final router = GoRouter(
    initialLocation: _getInitialLocationPath(),
    routes: <RouteBase>[
      GoRoute(
        name: welcomePageName,
        path: welcomePagePath,
        builder: (context, state) => WelcomePage(),
      ),
      GoRoute(
        name: loginPageName,
        path: loginPagePath,
        builder: (context, state) => LoginPage(),
      ),
    ],
  );

  static String _getInitialLocationPath() {
    if (!locator.get<CacheHelper>().isOnboardingCompleted()) {
      return welcomePagePath;
    } else {
      return loginPagePath;
    }
  }
}
