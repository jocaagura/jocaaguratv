import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../../domain/models/performer/performer.dart';
import 'card_pagination_widget.dart';
import 'performer_tile_widget.dart';
import 'trending_tile_widget.dart';

class TrendingPerformersCarrouselWidget extends StatefulWidget {
  const TrendingPerformersCarrouselWidget({
    required this.listOfPerformers,
    super.key,
  });

  final List<PerformerModel> listOfPerformers;
  // final PageController pageConstroller;

  @override
  State<TrendingPerformersCarrouselWidget> createState() =>
      _TrendingPerformersCarrouselWidgetState();
}

class _TrendingPerformersCarrouselWidgetState
    extends State<TrendingPerformersCarrouselWidget> {
  late PageController pageController;
  int currentPage = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    pageController.addListener(() {
      setState(() {});
    });
    timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      currentPage++;
      if (currentPage >= widget.listOfPerformers.length) {
        currentPage = 0;
      }
      updatePage(currentPage);
    });
  }

  void updatePage(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    final double mediaMenuWidth = MediaQuery.of(context).size.width * 0.075;

    return Stack(
      children: <Widget>[
        PageView.builder(
          controller: pageController,
          itemCount: widget.listOfPerformers.length,
          itemBuilder: (_, int index) {
            currentPage = index;
            return Row(
              children: <Widget>[
                Expanded(
                  child: PerformerTileWidget(
                    performer: widget.listOfPerformers[index],
                  ),
                ),
                SizedBox(
                  width: mediaMenuWidth,
                  child: ListView.builder(
                    itemCount: widget.listOfPerformers[index].knownFor.length,
                    itemBuilder: (_, int index2) {
                      return TrendingTileWidget(
                        showData: false,
                        size: Size(mediaMenuWidth, mediaMenuWidth * 1.65),
                        mediaModel:
                            widget.listOfPerformers[index].knownFor[index2],
                      );
                    },
                  ),
                ),
                const SizedBox(
                  width: 5.0,
                ),
              ],
            );
          },
        ),
        Positioned(
          bottom: 5.0,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: CardPaginationPageWidget(
                updateFunction: updatePage,
                currentPage: currentPage + 1,
                maxItems: widget.listOfPerformers.length,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    timer.cancel();
    super.dispose();
  }
}
