import 'package:musium/core/storage/cache_helper.dart';
import 'package:musium/core/dependency_injection/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelperImpl implements CacheHelper {
  static const onboardingCompletedKey = 'onboardingCompleted';
  @override
  Future<void> setOnboardingCompleted({required bool isCompleted}) async {
    await locator
        .get<SharedPreferences>()
        .setBool(onboardingCompletedKey, isCompleted);
  }

  @override
  bool isOnboardingCompleted() {
    return locator.get<SharedPreferences>().getBool(onboardingCompletedKey) ??
        false;
  }

  @override
  Future<void> clearCache() async {
    await locator.get<SharedPreferences>().clear();
  }
}
