import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musium/core/errors/failure.dart';
import 'package:musium/features/auth/data/data_sources/firebase_auth_service.dart';
import 'package:musium/features/auth/data/data_sources/user_remote_data_source.dart';
import 'package:musium/features/auth/data/models/user_model.dart';
import 'package:musium/features/auth/domain/entities/user_entity.dart';
import 'package:musium/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final FirebaseAuthService _firebaseAuthService;
  final UserRemoteDataSource _userRemoteDataSource;

  AuthRepoImpl({
    required FirebaseAuthService firebaseAuthService,
    required UserRemoteDataSource userRemoteDataSource,
  })  : _firebaseAuthService = firebaseAuthService,
        _userRemoteDataSource = userRemoteDataSource;

  @override
  Future<Either<Failure, UserEntity>> signup(
      {required UserEntity userEntity, required String password}) async {
    final result = await _firebaseAuthService.signup(
      email: userEntity.email,
      password: password,
    );
    return await result.fold(
      (failure) {
        return left(failure);
      },
      (userCredential) async {
        final UserModel userModel = UserModel.fromEntity(userEntity);
        final updatedUserModel = userModel.copyWith(
          uid: userCredential.user?.uid,
        );
        final savedUser = await _userRemoteDataSource.saveUserData(
          userModel: updatedUserModel,
        );

        return savedUser.fold(
          (failure) => left(failure),
          (_) => right(updatedUserModel),
        );
      },
    );
  }

  @override
  Future<Either<Failure, void>> login(
      {required String email, required String password}) async {
    final result = await _firebaseAuthService.login(
      email: email,
      password: password,
    );
    return result.fold(
      (failure) => left(failure),
      (_) => right(null), // Login successful, no data to return
    );
  }

  @override
  Stream<Either<Failure, User>> get authStatus async* {
    yield* _firebaseAuthService.authStatus;
  }

  @override
  Future<Either<Failure, UserEntity>> getUserData({required String uid}) async {
    final result = await _userRemoteDataSource.getUserData(uid: uid);
    return result.fold(
      (failure) => left(failure),
      (userModel) => right(userModel),
    );
  }
}
