import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musium/core/errors/failure.dart';

abstract class FirebaseAuthService {
  Future<Either<Failure, UserCredential>> signup({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> login({
    required String email,
    required String password,
  });

  Stream<Either<Failure, User>> get authStatus;
}

class FirebaseAuthServiceImpl extends FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthServiceImpl(this._firebaseAuth);
  @override
  Future<Either<Failure, UserCredential>> signup(
      {required String email, required String password}) async {
    try {
      final userCredentil = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(userCredentil);
    } on FirebaseAuthException catch (e) {
      final errMessage = _mapFirebaseAuthError(e.code);
      return left(Failure(message: errMessage, code: e.code));
    } catch (e) {
      return left(Failure(message: ' Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> login(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(null);
    } on FirebaseAuthException catch (e) {
      final errMessage = _mapFirebaseAuthError(e.code);
      return left(Failure(message: errMessage, code: e.code));
    } catch (e) {
      return left(Failure(message: ' Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Stream<Either<Failure, User>> get authStatus async* {
    try {
      await _firebaseAuth.currentUser?.reload();
      yield* _firebaseAuth.userChanges().map((user) {
        if (user != null) {
          return right(user);
        } else {
          return left(Failure(message: 'No user signed in.'));
        }
      });
    } on FirebaseAuthException catch (e) {
      yield left(Failure(
          message: 'FirebaseAuthException: ${e.message}', code: e.code));
    } catch (e) {
      yield left(
          Failure(message: 'Error getting auth status: ${e.toString()}'));
    }
  }

  String _mapFirebaseAuthError(String code) {
    switch (code) {
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'user-disabled':
        return 'This user has been disabled.';
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'An account already exists for this email.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      case 'weak-password':
        return 'Your password is too weak. Try a stronger one.';
      case 'too-many-requests':
        return 'Too many requests. Try again later.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection.';
      case 'invalid-credential':
        return 'invalid email or password';
      default:
        return 'An unknown error occurred. Please try again.';
    }
  }
}
