import 'package:flutter/material.dart';

import '../../../../../domain/either.dart';
import '../../../../../domain/failures/http_requets/http_request_failure.dart';
import '../../../../../domain/models/media/media_model.dart';
import '../../../../global/widgets/request_failed_widget.dart';
import 'trending_tile_widget.dart';

class TrendingCarrouselWidget extends StatelessWidget {
  const TrendingCarrouselWidget({
    required this.futureListMediaModel,
    required this.requestFailedWidget,
    super.key,
  });

  final Future<Either<HttpRequestFailure, List<MediaModel>>>
      futureListMediaModel;
  final RequestFailedWidget requestFailedWidget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: LayoutBuilder(
          builder: (_, BoxConstraints boxConstraints) {
            final double width = boxConstraints.maxHeight * 0.65;
            return FutureBuilder<Either<HttpRequestFailure, List<MediaModel>>>(
              future: futureListMediaModel,
              key: ValueKey<
                  Future<Either<HttpRequestFailure, List<MediaModel>>>>(
                futureListMediaModel,
              ),
              builder: (
                _,
                AsyncSnapshot<Either<HttpRequestFailure, List<MediaModel>>>
                    snapshot,
              ) {
                final Widget? result = snapshot.data?.when(
                  (HttpRequestFailure httpRequestFailure) =>
                      requestFailedWidget,
                  (List<MediaModel> list) {
                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, int index) {
                        final MediaModel mediaModel = list[index];
                        return TrendingTileWidget(
                          size: Size(
                            width,
                            boxConstraints.maxHeight,
                          ),
                          mediaModel: mediaModel,
                        );
                      },
                      itemCount: list.length,
                      separatorBuilder: (_, __) {
                        return SizedBox(
                          width: width * 0.05,
                        );
                      },
                      // itemExtent: height,
                      shrinkWrap: true,
                    );
                  },
                );

                return result ?? const CircularProgressIndicator();
              },
            );
          },
        ),
      ),
    );
  }
}
