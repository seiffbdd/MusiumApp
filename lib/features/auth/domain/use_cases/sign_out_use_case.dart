import 'package:dartz/dartz.dart';
import 'package:musium/core/errors/failure.dart';
import 'package:musium/core/utils/use_cases/use_case.dart';
import 'package:musium/features/auth/domain/repos/auth_repo.dart';
import 'package:musium/features/auth/domain/use_cases/no_params.dart';

class SignOutUseCase implements UseCase<Either<Failure, void>, NoParams> {
  final AuthRepo _authRepo;

  SignOutUseCase(this._authRepo);
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await _authRepo.signOut();
  }
}
