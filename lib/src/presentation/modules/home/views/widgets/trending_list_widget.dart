import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/either.dart';
import '../../../../../domain/enums.dart';
import '../../../../../domain/failures/http_requets/http_request_failure.dart';
import '../../../../../domain/models/media/media_model.dart';
import '../../../../../domain/repositories/trending_repository.dart';

class TrendingListWidget extends StatelessWidget {
  const TrendingListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TrendingRepository trendingRepositoryImpl = context.read();
    return SizedBox(
      height: 250.0,
      child: FutureBuilder<Either<HttpRequestFailure, List<MediaModel>>>(
        future: trendingRepositoryImpl.getMoviesAndSeries(TimeWindow.day),
        builder: (
          _,
          AsyncSnapshot<Either<HttpRequestFailure, List<MediaModel>>> snapshot,
        ) {
          final Text? result = snapshot.data?.when(
            (HttpRequestFailure httpRequestFailure) =>
                Text(httpRequestFailure.toString()),
            (List<MediaModel> p0) => Text('$p0'),
          );

          return result ?? const CircularProgressIndicator();
        },
      ),
    );
  }
}
