import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/movie_controller.dart';

class AppbarWidget extends StatelessWidget implements PreferredSize {
  const AppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final MovieController controller = context.watch();
    return AppBar(
      backgroundColor: Colors.transparent,
      actions: controller.state.mapOrNull(
        loaded: (_) => <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_outline,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget get child => const SizedBox.shrink();
}
