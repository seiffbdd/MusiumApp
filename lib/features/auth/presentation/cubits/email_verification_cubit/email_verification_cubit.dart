import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:musium/core/dependency_injection/service_locator.dart';
import 'package:musium/features/auth/domain/use_cases/no_params.dart';
import 'package:musium/features/auth/domain/use_cases/send_email_verification_use_case.dart';

part 'email_verification_state.dart';

class EmailVerificationCubit extends Cubit<EmailVerificationState> {
  final SendEmailVerificationUseCase _sendEmailVerificationUseCase;
  EmailVerificationCubit(this._sendEmailVerificationUseCase)
      : super(EmailVerificationInitial()) {
    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (timer) async {
        await checkEmailVerified();
      },
    );
  }

  Timer? _timer;

  Future<void> sendEmailVerification() async {
    final response =
        await _sendEmailVerificationUseCase.call(NoParams.instance);
    try {
      response.fold(
        (failure) => emit(
          SendingEmailFailed(errMessage: failure.message),
        ),
        (_) => emit(SendingEmailSuccess()),
      );
    } catch (e) {
      emit(SendingEmailFailed(errMessage: e.toString()));
    }
  }

  Future<void> checkEmailVerified() async {
    try {
      final User user = locator.get<FirebaseAuth>().currentUser!;
      await user.reload();
      if (user.emailVerified) {
        _timer?.cancel(); // Stop the timer once verified
        emit(EmailVerified());
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException during email check: ${e.message}');
      // Optionally emit a transient error state, or skip emission
    } catch (e) {
      debugPrint('Unexpected error checking email verification: $e');
      // Avoid throwing to prevent crashing
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
