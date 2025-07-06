import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musium/core/dependency_injection/service_locator.dart';
import 'package:musium/features/auth/data/data_sources/firebase_auth_service.dart';
import 'package:musium/features/auth/data/data_sources/ticker_data_source.dart';
import 'package:musium/features/auth/data/data_sources/user_remote_data_source.dart';
import 'package:musium/features/auth/data/repos/auth_repo_impl.dart';
import 'package:musium/features/auth/data/repos/ticker_repo_impl.dart';
import 'package:musium/features/auth/domain/repos/auth_repo.dart';
import 'package:musium/features/auth/domain/repos/ticker_repo.dart';
import 'package:musium/features/auth/domain/use_cases/count_down_use_case.dart';
import 'package:musium/features/auth/domain/use_cases/get_user_data_use_case.dart';
import 'package:musium/features/auth/domain/use_cases/is_email_exists_use_case.dart';
import 'package:musium/features/auth/domain/use_cases/listen_to_auth_state_use_case.dart';
import 'package:musium/features/auth/domain/use_cases/login_use_case.dart';
import 'package:musium/features/auth/domain/use_cases/send_email_verification_use_case.dart';
import 'package:musium/features/auth/domain/use_cases/send_password_reset_email_use_case.dart';
import 'package:musium/features/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:musium/features/auth/domain/use_cases/signup_use_case.dart';

Future<void> initAuthFeature() async {
  // Data Sources

  locator.registerLazySingleton<FirebaseAuthService>(
    () => FirebaseAuthServiceImpl(locator.get<FirebaseAuth>()),
  );

  locator.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(locator.get<FirebaseFirestore>()),
  );

  locator.registerLazySingleton<TickerDataSource>(
    () => TickerDataSourceImpl(),
  );

  // repos

  locator.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      firebaseAuthService: locator.get<FirebaseAuthService>(),
      userRemoteDataSource: locator.get<UserRemoteDataSource>(),
    ),
  );

  locator.registerLazySingleton<TickerRepo>(
    () => TickerRepoImpl(
      tickerDataSource: locator.get<TickerDataSource>(),
    ),
  );

  // UseCases

  locator.registerLazySingleton<SignupUseCase>(
    () => SignupUseCase(locator.get<AuthRepo>()),
  );
  locator.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(locator.get<AuthRepo>()),
  );

  locator.registerSingleton<ListenToAuthStateUseCase>(
    ListenToAuthStateUseCase(locator.get<AuthRepo>()),
  );

  locator.registerSingleton<GetUserDataUseCase>(
    GetUserDataUseCase(locator.get<AuthRepo>()),
  );

  locator.registerLazySingleton<SendEmailVerificationUseCase>(
    () => SendEmailVerificationUseCase(locator.get<AuthRepo>()),
  );

  locator.registerLazySingleton<CountDownUseCase>(
    () => CountDownUseCase(locator.get<TickerRepo>()),
  );

  locator.registerLazySingleton<SendPasswordResetEmailUseCase>(
    () => SendPasswordResetEmailUseCase(locator.get<AuthRepo>()),
  );

  locator.registerLazySingleton<SignOutUseCase>(
    () => SignOutUseCase(locator.get<AuthRepo>()),
  );

  locator.registerLazySingleton<IsEmailExistsUseCase>(
    () => IsEmailExistsUseCase(locator.get<AuthRepo>()),
  );
}
