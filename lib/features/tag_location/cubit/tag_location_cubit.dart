import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onspace/features/tag_location/data/model/profile.dart';
import 'package:onspace/features/tag_location/data/repository/tags_location_history.dart';

part 'tag_location_state.dart';

class TagLocationCubit extends Cubit<TagLocationState> {
  TagLocationCubit({required TagsLocationRepository tagsLocationRepository})
      : _tagsLocationRepository = tagsLocationRepository,
        super(TagLocationInitial()) {
    fetchTagsLocation();
  }

  final TagsLocationRepository _tagsLocationRepository;
  List<Profile> users = [];
  TagsLocationFilter filter = TagsLocationFilter.all;
  Map<Marker, Profile> markers = {};

  Future<void> fetchTagsLocation() async {
    try {
      emit(TagsLocationLoading());
      final tagsLocation = await _tagsLocationRepository.fetchTagsLocation();
      users = tagsLocation;
      emit(TagsLocationLoaded(tagsLocation: tagsLocation));
    } catch (e) {
      emit(TagsLocationError(errorMessage: e.toString()));
    }
  }

  Future<void> filterFetchedTagsLocation({
    required TagsLocationFilter selectedFilter,
  }) async {
    filter = selectedFilter;
    try {
      switch (selectedFilter) {
        case TagsLocationFilter.people:
          final filteredUsers = users
              .where(
                (element) => element.category!.toLowerCase().contains('people'),
              )
              .toList();
          emit(TagsLocationLoaded(tagsLocation: filteredUsers));
        case TagsLocationFilter.items:
          final filteredUsers = users
              .where(
                (element) => element.category!.toLowerCase().contains('item'),
              )
              .toList();
          emit(TagsLocationLoaded(tagsLocation: filteredUsers));
        case TagsLocationFilter.all:
          emit(TagsLocationLoaded(tagsLocation: users));
      }
    } catch (e) {
      emit(TagsLocationError(errorMessage: e.toString()));
    }
  }
}

enum TagsLocationFilter { people, items, all }
