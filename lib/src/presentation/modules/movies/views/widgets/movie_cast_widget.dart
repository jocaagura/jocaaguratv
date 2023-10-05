import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/either.dart';
import '../../../../../domain/failures/http_requets/http_request_failure.dart';
import '../../../../../domain/models/performer/performer.dart';
import '../../../../../domain/repositories/movies_repository.dart';
import '../../../../global/utils/get_umage_url.dart';
import '../../../../global/widgets/request_failed_widget.dart';

class MovieCastWidget extends StatefulWidget {
  const MovieCastWidget({
    required this.movieId,
    super.key,
  });
  final int movieId;
  @override
  State<MovieCastWidget> createState() => _MovieCastWidgetState();
}

class _MovieCastWidgetState extends State<MovieCastWidget> {
  late Future<Either<HttpRequestFailure, List<PerformerModel>>> _future;

  @override
  void initState() {
    super.initState();
    initFuture();
  }

  void initFuture() {
    _future = context.read<MoviesRepository>().getCastByMovieId(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Either<HttpRequestFailure, List<PerformerModel>>>(
      key: ValueKey<dynamic>(
        _future,
      ),
      future: _future,
      builder: (
        _,
        AsyncSnapshot<Either<HttpRequestFailure, List<PerformerModel>>>
            snapshot,
      ) {
        if (snapshot.data != null) {
          return snapshot.data!.when(
            (_) => RequestFailedWidget(
              onRetry: () {
                setState(() {
                  initFuture();
                });
              },
            ),
            (List<PerformerModel> cast) {
              return Column(
                children: <Widget>[
                  const Text(
                    'Cast',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                      separatorBuilder: (_, __) => const SizedBox(
                        width: 10.0,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: cast.length,
                      itemBuilder: (_, int index) {
                        final PerformerModel performerModel = cast[index];
                        return Column(
                          children: <Widget>[
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: ExtendedImage.network(
                                  getImageUrl(performerModel.profilePath),
                                ),
                              ),
                            ),
                            Text(
                              performerModel.name,
                              style: const TextStyle(
                                fontSize: 11.0,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
