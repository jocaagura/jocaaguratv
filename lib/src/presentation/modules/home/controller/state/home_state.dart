import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/enums.dart';
import '../../../../../domain/models/media/media_model.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    required bool loading,
    List<MediaModel>? moviesAndSeries,
    @Default(TimeWindow.day) TimeWindow timeWindow,
  }) = _HomeState;
}
