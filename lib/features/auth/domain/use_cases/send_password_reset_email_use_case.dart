import 'package:dartz/dartz.dart';
import 'package:musium/core/errors/failure.dart';
import 'package:musium/core/utils/use_cases/use_case.dart';
import 'package:musium/features/auth/domain/repos/auth_repo.dart';

class SendPasswordResetEmailUseCase
    implements UseCase<Either<Failure, void>, String> {
  final AuthRepo _authRepo;

  SendPasswordResetEmailUseCase(this._authRepo);

  @override
  Future<Either<Failure, void>> call(String email) async {
    return await _authRepo.sendPasswordResetEmail(email: email);
  }
}
