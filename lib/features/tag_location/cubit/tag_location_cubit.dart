import 'dart:ui' as ui;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onspace/features/tag_location/data/model/profile.dart';

import 'package:onspace/features/tag_location/data/repository/tags_location_history.dart';

import '../../profile/ui/screens/profile_screens.dart';

part 'tag_location_state.dart';

class TagLocationCubit extends Cubit<TagLocationState> {
  TagLocationCubit({required TagsLocationRepository tagsLocationRepository}) :
        _tagsLocationRepository = tagsLocationRepository, super(TagLocationInitial()){
    fetchTagsLocation();
  }
  final TagsLocationRepository _tagsLocationRepository;
  List<Profile> users = [];
  TagsLocationFilter filter = TagsLocationFilter.all;
  Map<Marker, Profile> markers = {};

  Future<void> fetchTagsLocation() async{
    try{
      emit(TagsLocationLoading());
      final tagsLocation = await _tagsLocationRepository.fetchTagsLocation();
      users = tagsLocation;
      emit(TagsLocationLoaded(tagsLocation: tagsLocation));
    }
    catch(e){
      emit(TagsLocationError(errorMessage: e.toString()));
    }
  }

  Future<void> filterFetchedTagsLocation(
      {required TagsLocationFilter selectedFilter}) async{
    filter = selectedFilter;
    try{
      switch(selectedFilter){
        case TagsLocationFilter.people:
          List<Profile> filteredUsers = users.where((element) =>
              element.category!.toLowerCase().contains("people")).toList();
          emit(TagsLocationLoaded(tagsLocation: filteredUsers));
          break;
        case TagsLocationFilter.items:
          List<Profile> filteredUsers = users.where((element) =>
              element.category!.toLowerCase().contains("item")).toList();
          emit(TagsLocationLoaded(tagsLocation: filteredUsers));
          break;
        case TagsLocationFilter.all:
        default:
          emit(TagsLocationLoaded(tagsLocation: users));
          break;
      }
    }
    catch(e){
      emit(TagsLocationError(errorMessage: e.toString()));
    }
  }

  // //  add a single marker to a map
  // addMarker(BuildContext context, Profile profile) async {
  //   final Uint8List icon =
  //   await getBytesFromAssets('assets/images/rider.png', 100);
  //   markers.putIfAbsent(
  //       Marker(
  //           markerId: MarkerId('${profile.userId}'),
  //           position:
  //           profile.location == null ? LatLng(0.0, 0.0) :
  //           LatLng(profile.location?.latitude == null ? 0 : profile.location!.latitude!,
  //               profile.location?.longitude == null ? 0 : profile.location!.longitude!),
  //           infoWindow: InfoWindow(
  //               title: "${profile.name}",
  //               snippet: "Tap for more details",
  //               onTap: () {
  //                 print('a location icon has been pressed.');
  //                 Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreens(userId: '${profile.userId}')));
  //               }),
  //           icon: BitmapDescriptor.fromBytes(icon)),
  //           () => profile);
  //
  //   // emit(state);
  //   debugPrint('state: $markers');
  //   markers = markers;
  //   emit(state);
  // }
  //
  // clearMarkers() {
  //   markers.clear();
  // }

}

enum TagsLocationFilter { people, items, all }

Future<Uint8List> getBytesFromAssets(String path, int width) async {
  final data = await rootBundle.load(path);
  final codec = await ui.instantiateImageCodec(
    data.buffer.asUint8List(),
    targetWidth: width,
  );
  final fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}
