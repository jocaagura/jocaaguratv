import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../../../domain/models/media/media_model.dart';
import '../../../../global/utils/get_umage_url.dart';

class TrendingTileWidget extends StatelessWidget {
  const TrendingTileWidget({
    required this.size,
    required this.mediaModel,
    super.key,
  });
  final Size size;

  final MediaModel mediaModel;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: <Widget>[
            ExtendedImage.network(
              getImageUrl(
                mediaModel.posterPath,
              ),
              fit: BoxFit.cover,
              borderRadius: BorderRadius.circular(5.0),
              loadStateChanged: (ExtendedImageState state) {
                if (state.extendedImageLoadState == LoadState.loading) {
                  return const CircularProgressIndicator(
                    color: Colors.black,
                  );
                }
                return state.completedWidget;
              },
            ),
            Positioned(
              right: 5.0,
              top: 10.0,
              child: Opacity(
                opacity: 0.55,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Chip(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      label: Text(
                        mediaModel.voteAverage.toStringAsFixed(1),
                      ),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Chip(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      label: Icon(
                        mediaModel.type == MediaType.movie
                            ? Icons.movie
                            : Icons.tv,
                        size: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
