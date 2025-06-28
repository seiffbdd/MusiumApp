import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:musium/core/storage/cache_helper.dart';
import 'package:musium/core/utils/service_locator.dart';
import 'package:musium/features/auth/domain/use_cases/login_use_case.dart';
import 'package:musium/features/auth/domain/use_cases/signup_use_case.dart';
import 'package:musium/features/auth/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:musium/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:musium/features/auth/presentation/pages/login_page.dart';
import 'package:musium/features/auth/presentation/pages/signup_page.dart';
import 'package:musium/features/home/presentation/pages/home_page.dart';
import 'package:musium/features/welcome/presentation/pages/welcome_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A centralized class to manage the application's route configuration.
abstract class AppRouter {
  static const welcomePageName = 'welcomePage';
  static const welcomePagePath = '/';

  static const loginPageName = 'loginPage';
  static const loginPagePath = '/loginPage';

  static const signupPageName = 'signupPage';
  static const signupPagePath = '/signupPage';

  static const homePageName = 'homePage';
  static const homePagePath = '/homePage';

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
        builder: (context, state) => BlocProvider(
          create: (context) => LoginCubit(locator.get<LoginUseCase>()),
          child: LoginPage(),
        ),
      ),
      GoRoute(
        name: signupPageName,
        path: signupPagePath,
        builder: (context, state) => BlocProvider(
          create: (context) => SignupCubit(locator.get<SignupUseCase>()),
          child: SignupPage(),
        ),
      ),
      GoRoute(
        name: homePageName,
        path: homePagePath,
        builder: (context, state) => HomePage(),
      ),
    ],
  );

  static String _getInitialLocationPath() {
    if (!locator.get<CacheHelper>().isOnboardingCompleted()) {
      return welcomePagePath;
    } else {
      if (locator.get<FirebaseAuth>().currentUser == null) {
        return loginPagePath;
      } else {
        return homePagePath;
      }
    }
  }
}
