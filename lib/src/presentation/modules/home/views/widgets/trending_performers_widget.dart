import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/models/performer/performer.dart';
import '../../../../global/widgets/request_failed_widget.dart';
import '../../controller/home_controller.dart';
import 'trending_performers_carrousel_widget.dart';

class TrendingPerformersWidget extends StatelessWidget {
  const TrendingPerformersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = context.watch();
    return homeController.state.when(
      loading: (_) => const CircularProgressIndicator(),
      failed: (_) => RequestFailedWidget(onRetry: homeController.init),
      loaded: (_, __, List<PerformerModel> performerList) =>
          TrendingPerformersCarrouselWidget(
        listOfPerformers: performerList,
      ),
    );
  }
}
