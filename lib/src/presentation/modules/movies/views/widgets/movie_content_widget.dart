import 'package:flutter/material.dart';

import '../../../../../domain/models/movie/movie_model.dart';
import '../../controller/state/movie_state.dart';
import 'movie_header_widget.dart';

class MovieContentWidget extends StatelessWidget {
  const MovieContentWidget({
    required this.movieState,
    super.key,
  });

  final MovieStateLoaded movieState;

  @override
  Widget build(BuildContext context) {
    final MovieModel movie = movieState.movieModel;
    final Color color = Theme.of(context).canvasColor;
    final TextStyle textStyle = TextStyle(
      color: color,
      fontWeight: FontWeight.bold,
    );
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          MovieHederWidget(
            movie: movie,
            textStyle: textStyle,
            color: color,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(movie.overview),
          ),
        ],
      ),
    );
  }
}
