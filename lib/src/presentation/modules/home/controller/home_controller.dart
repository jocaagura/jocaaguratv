import '../../../../domain/either.dart';
import '../../../../domain/failures/http_requets/http_request_failure.dart';
import '../../../../domain/models/media/media_model.dart';
import '../../../../domain/models/performer/performer.dart';
import '../../../../domain/repositories/trending_repository.dart';
import '../../../global/state_notifier.dart';
import 'state/home_state.dart';

class HomeController extends StateNotifier<HomeState> {
  HomeController(
    super.state, {
    required this.trendingRepository,
  });
  final TrendingRepository trendingRepository;

  Future<void> init() async {
    final Either<HttpRequestFailure, List<MediaModel>> result =
        await trendingRepository.getMoviesAndSeries(
      state.timeWindow,
    );
    final Either<HttpRequestFailure, List<PerformerModel>> performerResult =
        await trendingRepository.getPerformers();

    result.when((_) {
      state = HomeState.failed(state.timeWindow);
    }, (List<MediaModel> mediaModelList) {
      performerResult.when((_) {
        state = HomeState.failed(state.timeWindow);
      }, (List<PerformerModel> performerList) {
        state = HomeState.loaded(
          timeWindow: state.timeWindow,
          moviesAndSeries: mediaModelList,
          performerList: performerList,
        );
      });
    });
  }
}
