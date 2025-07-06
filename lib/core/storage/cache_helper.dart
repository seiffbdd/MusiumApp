abstract class CacheHelper {
  Future<void> setOnboardingCompleted({required bool isCompleted});

  bool isOnboardingCompleted();

  Future<void> clearCache();
}
