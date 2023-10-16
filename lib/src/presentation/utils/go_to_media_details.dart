import 'package:flutter/material.dart';

import '../../domain/models/media/media_model.dart';
import '../modules/movies/views/movie_view.dart';

Future<void> goToMediaDetails(
  BuildContext context,
  MediaModel mediaModel,
) async {
  if (mediaModel.type == MediaType.movie) {
    await Navigator.push(
      context,
      MaterialPageRoute<dynamic>(
        builder: (_) {
          return MovieView(
            movieId: mediaModel.id,
          );
        },
        settings: RouteSettings(name: '/movie/${mediaModel.id}'),
      ),
    );
  }
}
