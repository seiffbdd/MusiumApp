import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:musium/core/errors/failure.dart';
import 'package:musium/features/auth/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<Either<Failure, void>> saveUserData({required UserModel userModel});

  Future<Either<Failure, UserModel>> getUserData({required String uid});
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  static const String usersCollectionKey = 'users';
  final FirebaseFirestore _firestore;

  UserRemoteDataSourceImpl(this._firestore);
  @override
  Future<Either<Failure, void>> saveUserData(
      {required UserModel userModel}) async {
    try {
      await _firestore
          .collection(usersCollectionKey)
          .doc(userModel.uid)
          .set(userModel.toJson());
      return right(null);
    } on FirebaseException catch (e) {
      debugPrint('🔥 Firestore error: ${e.code} - ${e.message}');
      return left(
        Failure(
          message: 'Failed to save user data: ${e.message ?? 'Unknown error'}',
          code: e.code,
        ),
      );
    } catch (e) {
      debugPrint('❌ Unexpected error saving user data: $e');
      return left(Failure(message: 'Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUserData({required String uid}) async {
    try {
      final doc = await _firestore
          .collection(usersCollectionKey)
          .where('uid', isEqualTo: uid)
          .get();
      if (doc.docs.isNotEmpty) {
        return right(UserModel.fromJson(doc.docs.first.data()));
      } else {
        return left(Failure(
          message: 'No user found with uid: $uid',
          code: 'not-found',
        ));
      }
    } on FirebaseException catch (e) {
      debugPrint('🔥 Firestore error: ${e.code} - ${e.message}');
      return left(
        Failure(
          message: 'Failed to get user data: ${e.message ?? 'Unknown error'}',
          code: e.code,
        ),
      );
    } catch (e) {
      debugPrint('❌ Unexpected error getting user data: $e');
      return left(Failure(message: 'Unexpected error: $e'));
    }
  }
}
