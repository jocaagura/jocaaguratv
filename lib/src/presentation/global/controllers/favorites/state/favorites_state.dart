import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/models/media/media_model.dart';

part 'favorites_state.freezed.dart';

@freezed
class FavoritesState with _$FavoritesState {
  const factory FavoritesState.loading() = FavoritesStateLoading;
  const factory FavoritesState.failed() = FavoritesStateFailed;
  const factory FavoritesState.loaded({
    required Map<int, MediaModel> movies,
    required Map<int, MediaModel> series,
  }) = FavoritesStateLoaded;
}
