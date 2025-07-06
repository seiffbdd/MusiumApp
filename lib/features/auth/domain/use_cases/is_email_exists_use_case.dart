import 'package:dartz/dartz.dart';
import 'package:musium/core/errors/failure.dart';
import 'package:musium/core/utils/use_cases/use_case.dart';
import 'package:musium/features/auth/domain/repos/auth_repo.dart';

class IsEmailExistsUseCase implements UseCase<Either<Failure, bool>, String> {
  final AuthRepo _authRepo;

  IsEmailExistsUseCase(this._authRepo);

  @override
  Future<Either<Failure, bool>> call(String email) async {
    return await _authRepo.isEmailExists(email: email);
  }
}
