part of 'timer_cubit.dart';

sealed class TimerState extends Equatable {
  const TimerState({required this.duration});
  final int duration;

  @override
  List<Object> get props => [duration];
}

final class TimerInitial extends TimerState {
  const TimerInitial({required super.duration});
}

final class TimerInProgress extends TimerState {
  const TimerInProgress({required super.duration});
}

final class TimerFinished extends TimerState {
  const TimerFinished() : super(duration: 0);
}
