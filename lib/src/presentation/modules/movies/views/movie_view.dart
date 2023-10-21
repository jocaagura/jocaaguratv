import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../generated/translations.g.dart';
import '../../../global/widgets/request_failed_widget.dart';
import '../controller/movie_controller.dart';
import '../controller/state/movie_state.dart';
import 'widgets/appbar_widget.dart';
import 'widgets/movie_content_widget.dart';

class MovieView extends StatelessWidget {
  const MovieView({
    required this.movieId,
    super.key,
  });

  final int movieId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MovieController>(
      key: Key('movie-${LocaleSettings.currentLocale.languageCode}'),
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
          extendBodyBehindAppBar: true,
          appBar: const AppbarWidget(),
          body: controller.state.map(
            loading: (_) => const Center(
              child: CircularProgressIndicator(),
            ),
            failed: (_) => RequestFailedWidget(
              onRetry: controller.init,
            ),
            loaded: (MovieStateLoaded movieState) => MovieContentWidget(
              movieState: movieState,
            ),
          ),
        );
      },
    );
  }
}
