import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/either.dart';
import '../../../../../domain/enums.dart';
import '../../../../../domain/failures/http_requets/http_request_failure.dart';
import '../../../../../domain/models/media/media_model.dart';
import '../../../../../domain/repositories/trending_repository.dart';
import '../../../../global/widgets/request_failed_widget.dart';
import 'title_trending_tile_widget.dart';
import 'trending_carrousel_widget.dart';
import 'trending_timewindow_button_widget.dart';

class TrendingListWidget extends StatefulWidget {
  const TrendingListWidget({super.key});

  @override
  State<TrendingListWidget> createState() => _TrendingListWidgetState();
}

class _TrendingListWidgetState extends State<TrendingListWidget> {
  late Future<Either<HttpRequestFailure, List<MediaModel>>>
      futureListMediaModel;
  TimeWindow timeWindow = TimeWindow.day;
  @override
  void initState() {
    super.initState();
    userTimeWindow(timeWindow);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const TitleTrendingTileWidget(),
              TrendingTimewindowButtonWidget(
                dropDownFunction: dropDownFunction,
                timeWindow: timeWindow,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        TrendingCarrouselWidget(
          futureListMediaModel: futureListMediaModel,
          requestFailedWidget: RequestFailedWidget(
            onRetry: () {
              setState(() {
                userTimeWindow(timeWindow);
              });
            },
          ),
        ),
      ],
    );
  }

  void dropDownFunction(TimeWindow? timeWindow) {
    if (timeWindow != null && timeWindow != this.timeWindow) {
      setState(() {
        userTimeWindow(timeWindow);
      });
    }
  }

  Future<void> userTimeWindow(TimeWindow userTimeWindow) async {
    timeWindow = userTimeWindow;
    final TrendingRepository trendingRepositoryImpl = context.read();
    futureListMediaModel =
        trendingRepositoryImpl.getMoviesAndSeries(userTimeWindow);
  }
}
