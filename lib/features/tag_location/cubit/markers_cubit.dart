import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onspace/features/profile/ui/screens/profile_screens.dart';
import 'package:onspace/features/tag_location/data/model/profile.dart';

class MarkersCubit extends Cubit<Map<Marker, Profile>> {
  MarkersCubit() : super({});


  // Map<Marker, Profile> markers = {};
  //
  // Future<void> fetchTagsLocation() async{
  //   try{
  //     emit(TagsLocationLoading());
  //     final tagsLocation = await _tagsLocationHistory.fetchTagsLocation();
  //     emit(TagsLocationLoaded(tagsLocation: tagsLocation));
  //   }
  //   catch(e){
  //     emit(TagsLocationError(errorMessage: e.toString()));
  //   }
  // }

  // clear up markers with an empty set
  clearMarkers() {
    state.clear();
  }

//  add a single marker to a map
  addMarker(BuildContext context, Profile profile) async {
    final Uint8List icon =
    await getBytesFromAssets('assets/images/rider.png', 100);
    state.putIfAbsent(
        Marker(
            markerId: MarkerId('${profile.userId}'),
            position:
            profile.location == null ? LatLng(0.0, 0.0) :
            LatLng(profile.location?.latitude == null ? 0 : profile.location!.latitude!,
                profile.location?.longitude == null ? 0 : profile.location!.longitude!),
            infoWindow: InfoWindow(
                title: "${profile.name}",
                snippet: "Tap for more details",
                onTap: () {
                  print('a location icon has been pressed.');
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreens(userId: '${profile.userId}')));
                }),
            icon: BitmapDescriptor.fromBytes(icon)),
            () => profile);

    emit(state);
    // state = state;
  }
}

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