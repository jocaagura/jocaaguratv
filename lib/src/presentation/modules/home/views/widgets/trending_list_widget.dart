import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/either.dart';
import '../../../../../domain/enums.dart';
import '../../../../../domain/failures/http_requets/http_request_failure.dart';
import '../../../../../domain/models/media/media_model.dart';
import '../../../../../domain/repositories/trending_repository.dart';
import '../../../../global/utils/get_umage_url.dart';

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
    return SizedBox(
      height: 250.0,
      child: FutureBuilder<Either<HttpRequestFailure, List<MediaModel>>>(
        future: _future,
        builder: (
          _,
          AsyncSnapshot<Either<HttpRequestFailure, List<MediaModel>>> snapshot,
        ) {
          final Widget? result = snapshot.data?.when(
            (HttpRequestFailure httpRequestFailure) =>
                Text(httpRequestFailure.toString()),
            (List<MediaModel> list) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, int index) {
                  final MediaModel mediaModel = list[index];
                  return Image.network(
                    getImageUrl(
                      mediaModel.posterPath,
                    ),
                  );
                },
                itemCount: list.length,
              );
            },
          );

          return result ?? const CircularProgressIndicator();
        },
      ),
    );
  }
}
