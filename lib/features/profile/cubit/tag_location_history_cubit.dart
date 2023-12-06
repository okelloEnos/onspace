import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../tag_location/data/model/location_history.dart';
import '../../tag_location/data/repository/tags_location_history.dart';

part 'tag_location_history_state.dart';

class TagLocationHistoryCubit extends Cubit<TagLocationHistoryState> {
  final TagsLocationHistory _tagsLocationHistory;
  TagLocationHistoryCubit({required TagsLocationHistory tagsLocationHistory}) :
        _tagsLocationHistory = tagsLocationHistory,
        super(TagLocationHistoryInitial());

  Future<void> fetchTagsLocationHistory({required String userId}) async{
    try{
      emit(TagsLocationHistoryLoading());
      final tagsLocationHistory = await _tagsLocationHistory
          .fetchTagsLocationHistory();
      emit(TagsLocationHistoryLoaded(tagsLocationHistory: tagsLocationHistory));
    }
    catch(e){
      emit(TagsLocationHistoryError(errorMessage: e.toString()));
    }
  }
}
