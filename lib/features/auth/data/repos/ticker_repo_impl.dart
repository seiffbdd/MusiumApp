import 'package:musium/features/auth/data/data_sources/ticker_data_source.dart';
import 'package:musium/features/auth/domain/repos/ticker_repo.dart';

class TickerRepoImpl extends TickerRepo {
  final TickerDataSource _tickerDataSource;
  TickerRepoImpl({required TickerDataSource tickerDataSource})
      : _tickerDataSource = tickerDataSource;
  @override
  Stream<int> tick({required int ticks}) {
    return _tickerDataSource.tick(ticks: ticks);
  }
}
