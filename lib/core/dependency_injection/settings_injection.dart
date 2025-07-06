import 'package:musium/core/dependency_injection/service_locator.dart';
import 'package:musium/features/auth/domain/repos/auth_repo.dart';
import 'package:musium/features/settings/domain/use_cases/sign_out_use_case.dart';

Future<void> initSettingsFeature() async {
  // Use Cases
  locator.registerLazySingleton<SignOutUseCase>(
    () => SignOutUseCase(locator.get<AuthRepo>()),
  );
}
