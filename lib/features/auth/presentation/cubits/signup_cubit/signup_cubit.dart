import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:musium/features/auth/domain/entities/user_entity.dart';
import 'package:musium/features/auth/domain/use_cases/signup_use_case.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupUseCase _signupUseCase;

  SignupCubit(this._signupUseCase) : super(SignupInitial());

  Future<void> signup(
      {required String name,
      required String email,
      required String password}) async {
    emit(SignupLoading());
    try {
      final user = UserEntity(
        uid: '', // Firebase will generate this later
        name: name,
        email: email,
      );

      final result = await _signupUseCase(
        SignupParams(userEntity: user, password: password),
      );

      result.fold(
        (failure) {
          emit(SignupFailed(errMessage: failure.message));
        },
        (userEntity) {
          emit(SignupSuccess());
        },
      );
    } catch (e) {
      emit(SignupFailed(errMessage: e.toString()));
    }
  }
}
