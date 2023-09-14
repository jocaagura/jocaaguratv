import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/either.dart';
import '../../../../../domain/enums.dart';
import '../../../../../domain/failures/http_requets/http_request_failure.dart';
import '../../../../../domain/models/media/media_model.dart';
import '../../../../../domain/repositories/trending_repository.dart';
import 'trending_tile_widget.dart';

class TrendingListWidget extends StatefulWidget {
  const TrendingListWidget({super.key});

  @override
  State<TrendingListWidget> createState() => _TrendingListWidgetState();
}

class _TrendingListWidgetState extends State<TrendingListWidget> {
  late Future<Either<HttpRequestFailure, List<MediaModel>>> _future;
  @override
  void initState() {
    super.initState();
    final TrendingRepository trendingRepositoryImpl = context.read();
    _future = trendingRepositoryImpl.getMoviesAndSeries(TimeWindow.day);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Text(
            'TRENDING',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        AspectRatio(
          aspectRatio: 16 / 6,
          child: LayoutBuilder(
            builder: (_, BoxConstraints boxConstraints) {
              final double width = boxConstraints.maxHeight * 0.65;
              return FutureBuilder<
                  Either<HttpRequestFailure, List<MediaModel>>>(
                future: _future,
                builder: (
                  _,
                  AsyncSnapshot<Either<HttpRequestFailure, List<MediaModel>>>
                      snapshot,
                ) {
                  final Widget? result = snapshot.data?.when(
                    (HttpRequestFailure httpRequestFailure) =>
                        Text(httpRequestFailure.toString()),
                    (List<MediaModel> list) {
                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, int index) {
                          final MediaModel mediaModel = list[index];
                          return TrendingTileWidget(
                            mediaModel: mediaModel,
                          );
                        },
                        itemCount: list.length,
                        separatorBuilder: (_, __) {
                          return SizedBox(
                            width: width * 0.05,
                          );
                        },
                        // itemExtent: height,
                        shrinkWrap: true,
                      );
                    },
                  );

                  return result ?? const CircularProgressIndicator();
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
