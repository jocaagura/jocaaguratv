import '../../../../domain/either.dart';
import '../../../../domain/failures/http_requets/http_request_failure.dart';
import '../../../../domain/models/media/media_model.dart';
import '../../../../domain/repositories/account_repository.dart';
import '../../state_notifier.dart';
import 'state/favorites_state.dart';

class FavoritesController extends StateNotifier<FavoritesState> {
  FavoritesController(
    super.state, {
    required this.accountRepository,
  });
  final AccountRepository accountRepository;
  Future<void> init() async {
    final Either<HttpRequestFailure, Map<int, MediaModel>> moviesResult =
        await accountRepository.getFavorites(MediaType.movie);

    final FavoritesState newState = await moviesResult
        .when((_) async => const FavoritesState.failed(),
            (Map<int, MediaModel> moviesMediaModelMap) async {
      final Either<HttpRequestFailure, Map<int, MediaModel>> seriesResult =
          await accountRepository.getFavorites(MediaType.tv);
      return seriesResult.when(
        (HttpRequestFailure p0) => const FavoritesState.failed(),
        (Map<int, MediaModel> seriesMediaModelMap) => FavoritesState.loaded(
          movies: moviesMediaModelMap,
          series: seriesMediaModelMap,
        ),
      );
    });
    state = newState;
  }
}
