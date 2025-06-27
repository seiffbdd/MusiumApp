import 'package:dartz/dartz.dart';
import 'package:musium/core/errors/failure.dart';
import 'package:musium/core/utils/use_cases/use_case.dart';
import 'package:musium/features/auth/domain/entities/user_entity.dart';
import 'package:musium/features/auth/domain/repos/auth_repo.dart';

class SignupUseCase
    implements UseCase<Either<Failure, UserEntity>, SignupParams> {
  final AuthRepo _authRepo;

  SignupUseCase(this._authRepo);

  @override
  Future<Either<Failure, UserEntity>> call(SignupParams params) {
    return _authRepo.signup(
      userEntity: params.userEntity,
      password: params.password,
    );
  }
}

class SignupParams {
  final UserEntity userEntity;
  final String password;

  const SignupParams({
    required this.userEntity,
    required this.password,
  });
}
