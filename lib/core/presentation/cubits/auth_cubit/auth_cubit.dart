import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musium/core/errors/failure.dart';
import 'package:musium/features/auth/domain/entities/user_entity.dart';
import 'package:musium/features/auth/domain/use_cases/get_user_data_use_case.dart';
import 'package:musium/features/auth/domain/use_cases/listen_to_auth_state_use_case.dart';
import 'package:musium/features/auth/domain/use_cases/no_params.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final ListenToAuthStateUseCase _listenToAuthStateUseCase;
  final GetUserDataUseCase _getUserDataUseCase;

  AuthCubit(this._listenToAuthStateUseCase, this._getUserDataUseCase)
      : super(AuthInitial());

  late final StreamSubscription<Either<Failure, User>> _authSubscription;

  void listenToUserChanges() {
    try {
      _authSubscription = _listenToAuthStateUseCase(NoParams.instance).listen(
        (auth) {
          auth.fold(
            (failure) {
              _userEntity = null; // Reset user entity on failure
              emit(Unauthenticated(message: failure.message));
            },
            (user) async {
              await getUserData(uid: user.uid);
              if (user.emailVerified) {
                emit(AuthenticatedAndVerified());
              } else {
                emit(AuthenticatedButUnverified());
              }
            },
          );
        },
      );
    } catch (e) {
      _authSubscription.cancel();
      emit(UserDataFailed(errMessage: 'Error listening to auth state: $e'));
      return;
    }
  }

  Future<void> getUserData({required String uid}) async {
    try {
      final result = await _getUserDataUseCase(uid);
      result.fold(
        (failuer) => emit(
          UserDataFailed(errMessage: failuer.message),
        ),
        (userEntity) {
          setUserEntity(
            uid: userEntity.uid,
            name: userEntity.name,
            email: userEntity.email,
          );
          emit(AuthenticatedAndVerified());
        },
      );
    } catch (e) {
      emit(UserDataFailed(errMessage: 'Error getting user data: $e'));
    }
  }

  UserEntity? _userEntity;
  void setUserEntity(
      {required String uid, required String name, required String email}) {
    _userEntity = UserEntity(
      uid: uid,
      name: name,
      email: email,
    );
  }

  UserEntity? get userEntity => _userEntity;

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
