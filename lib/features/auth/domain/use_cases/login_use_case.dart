import 'package:dartz/dartz.dart';
import 'package:musium/core/errors/failure.dart';
import 'package:musium/core/utils/use_cases/use_case.dart';
import 'package:musium/features/auth/domain/repos/auth_repo.dart';

class LoginUseCase implements UseCase<Either<Failure, void>, LoginParams> {
  final AuthRepo _authRepo;

  const LoginUseCase(this._authRepo);

  @override
  Future<Either<Failure, void>> call(LoginParams params) async {
    return await _authRepo.login(
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
