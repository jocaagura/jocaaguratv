import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../global/controllers/favorites/favorites_controller.dart';
import '../../../../global/controllers/favorites/state/favorites_state.dart';
import '../../../../global/utils/mark_as_favorite.dart';
import '../../controller/movie_controller.dart';
import '../../controller/state/movie_state.dart';

class AppbarWidget extends StatelessWidget implements PreferredSize {
  const AppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final MovieController controller = context.watch();
    final FavoritesController favoritesController = context.watch();
    return AppBar(
      backgroundColor: Colors.transparent,
      actions: controller.state.mapOrNull(
        loaded: (MovieStateLoaded movieState) => <Widget>[
          favoritesController.state.maybeMap(
            orElse: () => Icon(
              Icons.error,
              color: Theme.of(context).colorScheme.error,
            ),
            loaded: (FavoritesStateLoaded favoriteState) => IconButton(
              onPressed: () {
                markAsFavorite(
                  context: context,
                  mediaModel: movieState.movieModel.toMedia(),
                  mounted: () => controller.mount,
                );
              },
              icon: Icon(
                favoriteState.movies.containsKey(movieState.movieModel.id)
                    ? Icons.favorite
                    : Icons.favorite_outline,
              ),
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
