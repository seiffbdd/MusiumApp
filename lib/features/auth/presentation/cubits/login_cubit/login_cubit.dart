import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:musium/features/auth/domain/use_cases/login_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  LoginCubit(this._loginUseCase) : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());

    try {
      final result = await _loginUseCase
          .call(LoginParams(email: email, password: password));
      result.fold(
        (failure) {
          emit(LoginFailed(errMessage: failure.message));
        },
        (_) {
          emit(LoginSuccess());
        },
      );
    } catch (e) {
      emit(LoginFailed(errMessage: e.toString()));
    }
  }
}
