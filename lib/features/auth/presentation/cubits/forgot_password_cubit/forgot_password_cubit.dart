import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:musium/features/auth/domain/use_cases/is_email_exists_use_case.dart';
import 'package:musium/features/auth/domain/use_cases/send_password_reset_email_use_case.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final SendPasswordResetEmailUseCase _sendPasswordResetEmailUseCase;
  final IsEmailExistsUseCase _isEmailExistsUseCase;

  ForgotPasswordCubit({
    required SendPasswordResetEmailUseCase sendPasswordResetEmailUseCase,
    required IsEmailExistsUseCase isEmailExistsUseCase,
  })  : _sendPasswordResetEmailUseCase = sendPasswordResetEmailUseCase,
        _isEmailExistsUseCase = isEmailExistsUseCase,
        super(ForgotPasswordInitial());
  Future<void> sendPasswordResetEmail({required String email}) async {
    emit(SendingPasswordResetEmailLoading());
    try {
      if (await emailExists(email)) {
        final result = await _sendPasswordResetEmailUseCase.call(email);
        result.fold(
          (failure) => emit(
              SendingPasswordResetEmailFailed(errMessage: failure.message)),
          (_) => emit(SendingPasswordResetEmailSuccess()),
        );
      } else {
        emit(SendingPasswordResetEmailFailed(
          errMessage: 'Couldn\'t find your email',
        ));
      }
    } catch (e) {
      emit(SendingPasswordResetEmailFailed(errMessage: e.toString()));
    }
  }

  Future<bool> emailExists(String email) async {
    final result = await _isEmailExistsUseCase.call(email);

    return result.fold(
      (failure) => false,
      (isExists) => isExists,
    );
  }
}
