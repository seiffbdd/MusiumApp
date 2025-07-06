import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:musium/core/dependency_injection/auth_injection.dart';
import 'package:musium/core/storage/cache_helper.dart';
import 'package:musium/core/storage/cache_helper_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> setup() async {
  // Cache
  locator.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );

  locator.registerSingleton<CacheHelper>(CacheHelperImpl());

  // Firebase core instances
  locator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  locator.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  // Call per-feature setup
  await initAuthFeature();
}
