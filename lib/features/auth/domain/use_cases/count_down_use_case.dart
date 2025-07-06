import 'package:musium/core/utils/use_cases/stream_use_case.dart';
import 'package:musium/features/auth/domain/repos/ticker_repo.dart';

class CountDownUseCase extends StreamUseCase<int, int> {
  final TickerRepo _tickerRepo;

  CountDownUseCase(this._tickerRepo);

  @override
  Stream<int> call(int ticks) {
    return _tickerRepo.tick(ticks: ticks);
  }
}
