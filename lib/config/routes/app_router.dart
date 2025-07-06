import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:musium/core/storage/cache_helper.dart';
import 'package:musium/core/dependency_injection/service_locator.dart';
import 'package:musium/features/auth/domain/use_cases/count_down_use_case.dart';
import 'package:musium/features/auth/domain/use_cases/is_email_exists_use_case.dart';
import 'package:musium/features/auth/domain/use_cases/login_use_case.dart';
import 'package:musium/features/auth/domain/use_cases/send_email_verification_use_case.dart';
import 'package:musium/features/auth/domain/use_cases/send_password_reset_email_use_case.dart';
import 'package:musium/features/auth/domain/use_cases/signup_use_case.dart';
import 'package:musium/features/auth/presentation/cubits/email_verification_cubit/email_verification_cubit.dart';
import 'package:musium/features/auth/presentation/cubits/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:musium/features/auth/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:musium/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:musium/features/auth/presentation/cubits/timer_cubit/timer_cubit.dart';
import 'package:musium/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:musium/features/auth/presentation/pages/verify_email_page.dart';
import 'package:musium/features/auth/presentation/pages/login_page.dart';
import 'package:musium/features/auth/presentation/pages/signup_page.dart';
import 'package:musium/features/home/presentation/pages/home_page.dart';
import 'package:musium/features/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:musium/features/settings/presentation/cubits/sign_out_cubit/sign_out_cubit.dart';
import 'package:musium/features/settings/presentation/pages/settings_page.dart';
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

  static const emailVerificationPageName = 'emailVerificationPage';
  static const emailVerificationPagePath = '/emailVerificationPage';

  static const forgotPasswordPageName = 'forgotPasswordPage';
  static const forgotPasswordPagePath = '/forgotPasswordPage';

  static const homePageName = 'homePage';
  static const homePagePath = '/homePage';

  static const settingsPageName = 'settingsPage';
  static const settingsPagePath = '/settingsPage';

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
        name: emailVerificationPageName,
        path: emailVerificationPagePath,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => EmailVerificationCubit(
                locator.get<SendEmailVerificationUseCase>(),
              ),
            ),
            BlocProvider(
              create: (context) => TimerCubit(
                countDownUseCase: locator.get<CountDownUseCase>(),
              ),
            )
          ],
          child: VerifyEmailPage(),
        ),
      ),
      GoRoute(
        name: forgotPasswordPageName,
        path: forgotPasswordPagePath,
        builder: (context, state) => BlocProvider(
          create: (context) => ForgotPasswordCubit(
              sendPasswordResetEmailUseCase:
                  locator.get<SendPasswordResetEmailUseCase>(),
              isEmailExistsUseCase: locator.get<IsEmailExistsUseCase>()),
          child: ForgotPasswordPage(),
        ),
      ),
      GoRoute(
        name: homePageName,
        path: homePagePath,
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        name: settingsPageName,
        path: settingsPagePath,
        builder: (context, state) => BlocProvider(
          create: (context) => SignOutCubit(locator.get<SignOutUseCase>()),
          child: SettingsPage(),
        ),
      ),
    ],
  );

  static String _getInitialLocationPath() {
    final user = locator.get<FirebaseAuth>().currentUser;
    if (user == null) {
      if (!locator.get<CacheHelper>().isOnboardingCompleted()) {
        return welcomePagePath;
      } else {
        return loginPagePath;
      }
    } else {
      if (user.emailVerified) {
        return homePagePath;
      } else {
        return emailVerificationPagePath;
      }
    }
  }
}
