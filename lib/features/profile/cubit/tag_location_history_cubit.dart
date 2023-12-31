import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:onspace/features/tag_location/data/model/profile.dart';
import 'package:onspace/features/tag_location/data/repository/tags_location_history.dart';

part 'tag_location_history_state.dart';

class TagLocationHistoryCubit extends Cubit<TagLocationHistoryState> {
  TagLocationHistoryCubit({
    required TagsLocationRepository tagsLocationHistory,
  })  : _tagsLocationHistory = tagsLocationHistory,
        super(TagLocationHistoryInitial());
  final TagsLocationRepository _tagsLocationHistory;

  Future<void> fetchTagsLocationHistory({required String userId}) async {
    try {
      emit(TagsLocationHistoryLoading());
      final tagsLocationHistory =
          await _tagsLocationHistory.fetchTagsLocationHistory();
      final locationHistory = tagsLocationHistory
              .firstWhere(
                (element) =>
                    element.userId?.toLowerCase() == userId.toLowerCase(),
              )
              .locationHistory ??
          [];
      emit(TagsLocationHistoryLoaded(tagsLocationHistory: locationHistory));
    } catch (e) {
      emit(TagsLocationHistoryError(errorMessage: e.toString()));
    }
  }
}
