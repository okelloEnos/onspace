import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:onspace/features/tag_location/data/model/profile.dart';

import '../data/repository/tags_location_history.dart';

part 'tag_location_state.dart';

class TagLocationCubit extends Cubit<TagLocationState> {
  final TagsLocationHistory _tagsLocationHistory;
  TagLocationCubit({required TagsLocationHistory tagsLocationHistory}) :
        _tagsLocationHistory = tagsLocationHistory, super(TagLocationInitial()){
    fetchTagsLocation();
  }

  Future<void> fetchTagsLocation() async{
    try{
      emit(TagsLocationLoading());
      final tagsLocation = await _tagsLocationHistory.fetchTagsLocation();
      emit(TagsLocationLoaded(tagsLocation: tagsLocation));
    }
    catch(e){
      emit(TagsLocationError(errorMessage: e.toString()));
    }
  }
}
