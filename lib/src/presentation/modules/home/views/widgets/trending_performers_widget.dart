import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/either.dart';
import '../../../../../domain/failures/http_requets/http_request_failure.dart';
import '../../../../../domain/models/performer/performer.dart';
import '../../../../../domain/repositories/trending_repository.dart';
import '../../../../global/widgets/request_failed_widget.dart';
import 'trending_performers_carrousel_widget.dart';

class TrendingPerformersWidget extends StatefulWidget {
  const TrendingPerformersWidget({super.key});

  @override
  State<TrendingPerformersWidget> createState() =>
      _TrendingPerformersWidgetState();
}

class _TrendingPerformersWidgetState extends State<TrendingPerformersWidget> {
  late Future<Either<HttpRequestFailure, List<PerformerModel>>>
      futureListPerformer;

  @override
  void initState() {
    super.initState();
    futureListPerformer = context.read<TrendingRepository>().getPerformers();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Either<HttpRequestFailure, List<PerformerModel>>>(
      key: ValueKey<dynamic>(futureListPerformer),
      future: futureListPerformer,
      builder: (
        _,
        AsyncSnapshot<Either<HttpRequestFailure, List<PerformerModel>>>
            snapshot,
      ) {
        if (snapshot.hasData) {
          return snapshot.data?.when(
                (HttpRequestFailure p0) => RequestFailedWidget(
                  onRetry: () {
                    setState(() {
                      futureListPerformer =
                          context.read<TrendingRepository>().getPerformers();
                    });
                  },
                  text: p0.toString(),
                ),
                (List<PerformerModel> p0) => TrendingPerformersCarrouselWidget(
                  listOfPerformers: p0,
                ),
              ) ??
              const Center(
                child: Text('No data'),
              );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
