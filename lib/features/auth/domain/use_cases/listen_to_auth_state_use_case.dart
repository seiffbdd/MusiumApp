import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musium/core/errors/failure.dart';
import 'package:musium/core/utils/use_cases/stream_use_case.dart';
import 'package:musium/features/auth/domain/repos/auth_repo.dart';
import 'package:musium/features/auth/domain/use_cases/no_params.dart';

class ListenToAuthStateUseCase
    implements StreamUseCase<Either<Failure, User>, NoParams> {
  final AuthRepo _authRepo;

  const ListenToAuthStateUseCase(this._authRepo);

  @override
  Stream<Either<Failure, User>> call(NoParams params) => _authRepo.authStatus;
}
