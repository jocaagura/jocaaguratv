import 'package:flutter/material.dart';

import '../../../../../domain/models/media/media_model.dart';
import '../../../../global/utils/get_umage_url.dart';

class TrendingTileWidget extends StatelessWidget {
  const TrendingTileWidget({
    required this.mediaModel,
    super.key,
  });

  final MediaModel mediaModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Positioned.fill(
            child: Image.network(
              getImageUrl(
                mediaModel.posterPath,
              ),
            ),
          ),
        ),
        Positioned(
          right: 5.0,
          top: 10.0,
          child: Chip(
            label: Text(
              mediaModel.voteAverage.toStringAsFixed(1),
            ),
          ),
        ),
      ],
    );
  }
}
