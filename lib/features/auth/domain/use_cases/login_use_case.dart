import 'package:dartz/dartz.dart';
import 'package:musium/core/errors/failure.dart';
import 'package:musium/core/utils/use_cases/use_case.dart' show UseCase;
import 'package:musium/features/auth/domain/repos/auth_repo.dart';

class LoginUseCase implements UseCase<Either<Failure, void>, LoginParams> {
  final AuthRepo _authRepo;

  LoginUseCase(this._authRepo);

  @override
  Future<Either<Failure, void>> call(LoginParams params) {
    return _authRepo.login(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginParams {
  final String email;
  final String password;

  const LoginParams({
    required this.email,
    required this.password,
  });
}
