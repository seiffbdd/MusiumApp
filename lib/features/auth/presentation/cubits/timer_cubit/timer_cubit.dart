import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:musium/features/auth/domain/use_cases/count_down_use_case.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  final CountDownUseCase _countDownUseCase;

  static const int _duration = 60;

  TimerCubit({required CountDownUseCase countDownUseCase})
      : _countDownUseCase = countDownUseCase,
        super(TimerInitial(duration: _duration));

  StreamSubscription<int>? _countDownSubscription;

  void startTimer() {
    emit(TimerInProgress(duration: _duration));
    _countDownSubscription?.cancel();
    _countDownSubscription = _countDownUseCase.call(_duration).listen(
      (duration) {
        if (duration <= 0) {
          emit(const TimerFinished());
        } else {
          emit(TimerInProgress(duration: duration));
        }
      },
    );
  }

  void resetTimer() {
    _countDownSubscription?.cancel();
    emit(const TimerInitial(duration: _duration));
  }

  @override
  Future<void> close() {
    _countDownSubscription?.cancel();
    return super.close();
  }
}
