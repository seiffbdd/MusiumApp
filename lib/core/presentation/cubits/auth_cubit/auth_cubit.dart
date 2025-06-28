import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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

  void listenToUserChanges() {
    try {
      _listenToAuthStateUseCase(NoParams()).listen(
        (auth) {
          auth.fold(
            (failure) {
              emit(Unauthenticated(message: failure.message));
            },
            (user) async {
              await getUserData(uid: user.uid);
            },
          );
        },
      );
    } catch (e) {
      emit(UserDataFailed(errMessage: 'Error listening to auth state: $e'));
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
          emit(Authenticated());
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
}
