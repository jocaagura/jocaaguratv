import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/movie/movie_model.dart';
import '../../../global/widgets/request_failed_widget.dart';
import '../controller/movie_controller.dart';
import '../controller/state/movie_state.dart';

class MovieView extends StatelessWidget {
  const MovieView({
    required this.movieId,
    super.key,
  });

  final int movieId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MovieController>(
      create: (_) {
        return MovieController(
          MovieState.loading(),
          moviesRepository: context.read(),
          movieId: movieId,
        )..init();
      },
      builder: (BuildContext contextb, _) {
        final MovieController controller = contextb.watch();
        return Scaffold(
          appBar: AppBar(),
          body: controller.state.when(
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            failed: () => RequestFailedWidget(
              onRetry: controller.init,
            ),
            loaded: (MovieModel movieModel) => Center(
              child: Text('$movieModel'),
            ),
          ),
        );
      },
    );
  }
}
