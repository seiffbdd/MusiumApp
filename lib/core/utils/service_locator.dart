import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:musium/core/storage/cache_helper.dart';
import 'package:musium/features/auth/data/data_sources/firebase_auth_service.dart';
import 'package:musium/features/auth/data/data_sources/user_remote_data_source.dart';
import 'package:musium/features/auth/data/repos/auth_repo_impl.dart';
import 'package:musium/features/auth/domain/repos/auth_repo.dart';
import 'package:musium/features/auth/domain/use_cases/get_user_data_use_case.dart';
import 'package:musium/features/auth/domain/use_cases/listen_to_auth_state_use_case.dart';
import 'package:musium/features/auth/domain/use_cases/login_use_case.dart';
import 'package:musium/features/auth/domain/use_cases/signup_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> setup() async {
  // Cache
  locator.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );

  locator.registerSingleton<CacheHelper>(CacheHelper());

  // Data Sources

  locator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  locator.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  locator.registerLazySingleton<FirebaseAuthService>(
    () => FirebaseAuthServiceImpl(locator.get<FirebaseAuth>()),
  );

  locator.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(locator.get<FirebaseFirestore>()),
  );

  // repos

  locator.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      firebaseAuthService: locator.get<FirebaseAuthService>(),
      userRemoteDataSource: locator.get<UserRemoteDataSource>(),
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
}
