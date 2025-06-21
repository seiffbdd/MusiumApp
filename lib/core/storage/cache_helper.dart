import 'package:musium/core/utils/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static const onboardingCompletedKey = 'onboardingCompleted';

  Future<void> setOnboardingCompleted({required bool isCompleted}) async {
    await locator
        .get<SharedPreferences>()
        .setBool(onboardingCompletedKey, isCompleted);
  }

  bool isOnboardingCompleted() {
    return locator.get<SharedPreferences>().getBool(onboardingCompletedKey) ??
        false;
  }

  Future<void> clearCache() async {
    await locator.get<SharedPreferences>().clear();
  }
}
