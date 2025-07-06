import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:musium/features/auth/domain/use_cases/no_params.dart';
import 'package:musium/features/settings/domain/use_cases/sign_out_use_case.dart';

part 'sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  final SignOutUseCase _signOutUseCase;
  SignOutCubit(this._signOutUseCase) : super(SignOutInitial());

  Future<void> signOut() async {
    try {
      emit(SignOutLoading());

      final result = await _signOutUseCase(NoParams.instance);

      result.fold(
        (failure) {
          emit(SignOutFailed(errMessage: failure.message));
        },
        (_) {},
      );
    } catch (error) {
      emit(SignOutFailed(errMessage: error.toString()));
    }
  }
}
