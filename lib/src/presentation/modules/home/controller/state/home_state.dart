import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/enums.dart';
import '../../../../../domain/models/media/media_model.dart';
import '../../../../../domain/models/performer/performer.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    @Default(
      MoviesAndSeriesState.loading(TimeWindow.day),
    )
    MoviesAndSeriesState moviesAndSeriesState,
    @Default(
      PerformerModelListState.loading(),
    )
    PerformerModelListState performerModelListState,
  }) = _HomeState;
}

@freezed
class MoviesAndSeriesState with _$MoviesAndSeriesState {
  const factory MoviesAndSeriesState.loading(TimeWindow timeWindow) =
      MoviesAndSeriesStateLoading;
  const factory MoviesAndSeriesState.failed(TimeWindow timeWindow) =
      MoviesAndSeriesStateFailed;
  const factory MoviesAndSeriesState.loaded({
    required TimeWindow timeWindow,
    required List<MediaModel> moviesAndSeriesList,
  }) = MoviesAndSeriesStateLoaded;
}

@freezed
class PerformerModelListState with _$PerformerModelListState {
  const factory PerformerModelListState.loading() =
      PerformerModelListStateLoading;
  const factory PerformerModelListState.failed() =
      PerformerModelListStateFailed;
  const factory PerformerModelListState.loaded(
    List<PerformerModel> performerList,
  ) = PerformerModelListStateLoaded;
}
