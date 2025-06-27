import 'package:dartz/dartz.dart';
import 'package:musium/core/errors/failure.dart';
import 'package:musium/core/utils/use_cases/use_case.dart';
import 'package:musium/features/auth/domain/entities/user_entity.dart';
import 'package:musium/features/auth/domain/repos/auth_repo.dart';

class GetUserDataUseCase
    implements UseCase<Either<Failure, UserEntity>, String> {
  final AuthRepo _authRepo;

  GetUserDataUseCase(this._authRepo);

  @override
  Future<Either<Failure, UserEntity>> call(String params) async {
    return await _authRepo.getUserData(uid: params);
  }
}
