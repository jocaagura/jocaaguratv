import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/either.dart';
import '../../../domain/failures/http_requets/http_request_failure.dart';
import '../../../domain/models/media/media_model.dart';
import '../controllers/favorites/favorites_controller.dart';
import '../dialogs/show_loader.dart';

Future<void> markAsFavorite({
  required BuildContext context,
  required MediaModel mediaModel,
  required bool Function() mounted,
}) async {
  final FavoritesController favoritesController = context.read();
  final Either<HttpRequestFailure, void>? result = await showLoader(
    context,
    favoritesController.markAsFavorite(
      mediaModel,
    ),
  );

  if (mounted()) {
    return;
  }
  result?.when(
    (HttpRequestFailure failure) {
      final String errorMsg = failure.when(
        notFound: () => 'Resource not found',
        network: () => 'Network error',
        unauthorized: () => 'Unauthorized',
        unknow: () => 'Unknow error',
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMsg),
        ),
      );
    },
    (_) => null,
  );
}
