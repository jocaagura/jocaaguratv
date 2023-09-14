import 'package:flutter/material.dart';

class TitleTrendingTileWidget extends StatelessWidget {
  const TitleTrendingTileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'TRENDING',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
