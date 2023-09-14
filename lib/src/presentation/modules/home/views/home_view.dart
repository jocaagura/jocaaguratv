import 'package:flutter/material.dart';

import 'widgets/trending_list_widget.dart';
import 'widgets/trending_performers_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: <Widget>[
          _SeparatorWidget(),
          TrendingListWidget(),
          _SeparatorWidget(),
          TrendingPerformersWidget(),
        ],
      ),
    );
  }
}

class _SeparatorWidget extends StatelessWidget {
  const _SeparatorWidget();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 10.0,
    );
  }
}
