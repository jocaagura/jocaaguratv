import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/enums.dart';
import '../../controller/home_controller.dart';
import 'title_trending_tile_widget.dart';
import 'trending_carrousel_widget.dart';
import 'trending_timewindow_button_widget.dart';

class TrendingListWidget extends StatelessWidget {
  const TrendingListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final HomeController controller = context.watch();

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
                dropDownFunction: (TimeWindow? timeWindow) {
                  controller.init();
                },
                timeWindow: controller.state.moviesAndSeriesState.timeWindow,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        const TrendingCarrouselWidget(),
      ],
    );
  }
}
