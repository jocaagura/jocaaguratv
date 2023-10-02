import '../../../../domain/either.dart';
import '../../../../domain/failures/http_requets/http_request_failure.dart';
import '../../../../domain/models/movie/movie_model.dart';
import '../../../../domain/repositories/movies_repository.dart';
import '../../../global/state_notifier.dart';
import 'state/movie_state.dart';

class MovieController extends StateNotifier<MovieState> {
  MovieController(
    super.state, {
    required this.moviesRepository,
    required this.movieId,
  });
  final MoviesRepository moviesRepository;
  final int movieId;
  Future<void> init() async {
    final Either<HttpRequestFailure, MovieModel> result =
        await moviesRepository.getMovieById(movieId);
    state = result.when(
      (_) => MovieState.failed(),
      (MovieModel movieModel) => MovieState.loaded(movieModel),
    );
  }
}
