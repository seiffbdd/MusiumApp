import 'package:get_it/get_it.dart';
import 'package:musium/core/storage/cache_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> setup() async {
  locator.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );

  locator.registerSingleton<CacheHelper>(CacheHelper());
}
