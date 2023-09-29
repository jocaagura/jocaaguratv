import 'package:flutter/material.dart';
import 'package:jocaaguratv/src/presentation/modules/home/views/widgets/trending_tile_widget.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/models/media/media_model.dart';
import '../../../../global/widgets/request_failed_widget.dart';
import '../../controller/home_controller.dart';

class TrendingCarrouselWidget extends StatelessWidget {
  const TrendingCarrouselWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final HomeController controller = context.watch();

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: LayoutBuilder(
          builder: (_, BoxConstraints boxConstraints) {
            final double width = boxConstraints.maxHeight * 0.65;
            return Center(
              child: controller.state.when(
                loading: (_) => const CircularProgressIndicator(),
                failed: (_) => RequestFailedWidget(onRetry: controller.init),
                loaded: (_, List<MediaModel> list) => ListView.separated(
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
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
