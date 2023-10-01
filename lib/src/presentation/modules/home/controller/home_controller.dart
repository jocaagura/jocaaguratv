import '../../../../domain/either.dart';
import '../../../../domain/enums.dart';
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
    await loadMoviesAndSeries();
    await loadPerformers();
  }

  void onTimeWindowChanged(TimeWindow? timeWindow) {
    if (state.moviesAndSeriesState.timeWindow != timeWindow) {
      // state = state.copyWith(
      //   moviesAndSeriesState: state.moviesAndSeriesState.l
      //       .copyWith(timeWindow: timeWindow ?? TimeWindow.day),
      // );
      state = state.copyWith(
        moviesAndSeriesState:
            MoviesAndSeriesState.loading(timeWindow ?? TimeWindow.day),
      );
      loadMoviesAndSeries();
      loadPerformers();
    }
  }

  Future<void> loadPerformers() async {
    final Either<HttpRequestFailure, List<PerformerModel>> performerResult =
        await trendingRepository.getPerformers();
    performerResult.when(
      (_) {
        return state = state.copyWith(
          performerModelListState: const PerformerModelListState.failed(),
        );
      },
      (List<PerformerModel> performerList) {
        state = state.copyWith(
          performerModelListState:
              PerformerModelListState.loaded(performerList),
        );
      },
    );
  }

  Future<void> loadMoviesAndSeries() async {
    final Either<HttpRequestFailure, List<MediaModel>> result =
        await trendingRepository
            .getMoviesAndSeries(state.moviesAndSeriesState.timeWindow);
    result.when(
      (_) {
        return state = state.copyWith(
          moviesAndSeriesState: MoviesAndSeriesState.failed(
            state.moviesAndSeriesState.timeWindow,
          ),
        );
      },
      (List<MediaModel> mediaModelList) {
        state = state.copyWith(
          moviesAndSeriesState: MoviesAndSeriesState.loaded(
            timeWindow: state.moviesAndSeriesState.timeWindow,
            moviesAndSeriesList: mediaModelList,
          ),
        );
      },
    );
  }
}
