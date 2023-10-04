import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../../../domain/models/genre_model/genre_model.dart';
import '../../../../../domain/models/movie/movie_model.dart';
import '../../../../global/utils/get_umage_url.dart';

class MovieHederWidget extends StatelessWidget {
  const MovieHederWidget({
    required this.movie,
    required this.textStyle,
    required this.color,
    super.key,
  });

  final MovieModel movie;
  final TextStyle textStyle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.35,
          child: AspectRatio(
            aspectRatio: 16 / 13,
            child: ExtendedImage.network(
              getImageUrl(movie.backdropPath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          left: 0,
          bottom: 8.0,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.96,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Colors.black38,
                  Colors.black54,
                  Colors.black38,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.0),
                topRight: Radius.circular(5.0),
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        movie.title,
                        style: textStyle,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Wrap(
                        spacing: 8.0,
                        children: movie.genres
                            .map(
                              (GenreModel e) => Container(
                                padding: const EdgeInsets.all(3.5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                    color: color,
                                  ),
                                ),
                                child: Text(
                                  e.name,
                                  style: textStyle.copyWith(fontSize: 10.0),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator(
                        value: ((movie.voteAverage) / 10).clamp(0.0, 1.0),
                      ),
                    ),
                    Text(
                      movie.voteAverage.toStringAsFixed(1),
                      style: textStyle.copyWith(fontSize: 24),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
