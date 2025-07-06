import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musium/core/errors/failure.dart';
import 'package:musium/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> signup({
    required UserEntity userEntity,
    required String password,
  });
  Future<Either<Failure, void>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, void>> sendEmailVerification();

  Stream<Either<Failure, User>> get authStatus;

  Future<Either<Failure, UserEntity>> getUserData({required String uid});
}
