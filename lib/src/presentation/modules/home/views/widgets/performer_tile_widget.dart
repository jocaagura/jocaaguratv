import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../../../domain/models/performer/performer.dart';
import '../../../../global/utils/get_umage_url.dart';

class PerformerTileWidget extends StatelessWidget {
  const PerformerTileWidget({
    required this.performer,
    super.key,
  });

  final PerformerModel performer;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: ExtendedImage.network(
                getImageUrl(
                  performer.profilePath,
                  imageQuality: ImageQuality.original,
                ),
                fit: BoxFit.cover,
                loadStateChanged: (ExtendedImageState state) {
                  if (state.extendedImageLoadState == LoadState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    );
                  }
                  return state.completedWidget;
                },
              ),
            ),
          ),
          Positioned(
            right: 7.0,
            bottom: 4.0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                // color: Theme.of(context).colorScheme.background,
                gradient: LinearGradient(
                  colors: <Color>[
                    Theme.of(context).colorScheme.background,
                    Theme.of(context).colorScheme.background.withOpacity(0.35),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(performer.name),
                  Text(
                    performer.originalName,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    performer.popularity.toStringAsFixed(1),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
