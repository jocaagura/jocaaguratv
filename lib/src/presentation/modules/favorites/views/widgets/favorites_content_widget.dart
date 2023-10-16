import 'package:flutter/material.dart';

import '../../../../global/controllers/favorites/state/favorites_state.dart';
import 'favorites_list_widget.dart';

class FavoritesContent extends StatelessWidget {
  const FavoritesContent({
    required this.state,
    required this.tabController,
    super.key,
  });

  final FavoritesStateLoaded state;
  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: <Widget>[
        FavoritesListWidget(items: state.movies.values.toList()),
        FavoritesListWidget(items: state.series.values.toList()),
      ],
    );
  }
}
