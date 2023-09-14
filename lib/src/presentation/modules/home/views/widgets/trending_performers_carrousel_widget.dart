import 'package:flutter/material.dart';

import '../../../../../domain/models/performer/performer.dart';
import 'performer_tile_widget.dart';

class TrendingPerformersCarrouselWidget extends StatelessWidget {
  const TrendingPerformersCarrouselWidget({
    required this.listOfPerformers,
    super.key,
  });

  final List<PerformerModel> listOfPerformers;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: listOfPerformers.length,
      itemBuilder: (_, int index) {
        return PerformerTileWidget(performer: listOfPerformers[index]);
      },
    );
  }
}
