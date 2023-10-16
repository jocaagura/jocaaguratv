import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/controllers/favorites/favorites_controller.dart';
import '../../../global/controllers/favorites/state/favorites_state.dart';
import '../../../global/widgets/request_failed_widget.dart';
import 'widgets/favorites_content_widget.dart';
import 'widgets/favorites_tab_bar_widget.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FavoritesController favoritesController = context.watch();
    return Scaffold(
      appBar: FavoritesTabBarWidget(
        tabController: tabController,
      ),
      body: favoritesController.state.map(
        loading: (_) => const Center(
          child: CircularProgressIndicator(),
        ),
        failed: (_) {
          return RequestFailedWidget(
            onRetry: favoritesController.init,
          );
        },
        loaded: (FavoritesStateLoaded state) =>
            FavoritesContent(state: state, tabController: tabController),
      ),
    );
  }
}
