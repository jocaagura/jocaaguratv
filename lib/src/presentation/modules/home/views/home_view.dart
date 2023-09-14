import 'package:flutter/material.dart';

import 'widgets/trending_list_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[TrendingListWidget()],
      ),
    );
  }
}
