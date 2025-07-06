import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:musium/core/errors/failure.dart';
import 'package:musium/features/auth/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<Either<Failure, void>> saveUserData({required UserModel userModel});

  Future<Either<Failure, UserModel>> getUserData({required String uid});

  Future<Either<Failure, bool>> isEmailExists({required String email});
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  static const String _usersCollectionKey = 'users';
  late CollectionReference<Map<String, dynamic>> _usersCollectionReference;

  final FirebaseFirestore _firestore;

  UserRemoteDataSourceImpl(this._firestore) {
    _usersCollectionReference = _firestore.collection(_usersCollectionKey);
  }

  @override
  Future<Either<Failure, void>> saveUserData(
      {required UserModel userModel}) async {
    try {
      await _usersCollectionReference
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
      final doc =
          await _usersCollectionReference.where('uid', isEqualTo: uid).get();
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
          message: '${e.message}',
          code: e.code,
        ),
      );
    } catch (e) {
      debugPrint('❌ Unexpected error getting user data: $e');
      return left(Failure(message: '$e'));
    }
  }

  @override
  Future<Either<Failure, bool>> isEmailExists({required String email}) async {
    try {
      final doc = await _usersCollectionReference
          .where('email', isEqualTo: email)
          .get();
      if (doc.docs.isNotEmpty) {
        return right(true);
      } else {
        return right(false);
      }
    } on FirebaseException catch (e) {
      debugPrint('🔥 Firestore error: ${e.code} - ${e.message}');
      return left(
        Failure(
          message: '${e.message}',
          code: e.code,
        ),
      );
    } catch (e) {
      debugPrint('❌ Unexpected error getting user data: $e');
      return left(Failure(message: '$e'));
    }
  }
}
