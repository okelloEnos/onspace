import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onspace/features/profile/ui/screens/profile_screens.dart';
import 'package:onspace/features/tag_location/data/model/profile.dart';

class MarkersCubit extends Cubit<Map<Marker, Profile>> {
  MarkersCubit() : super({});

  void clearMarkers() {
    emit({});
  }

  Future<void> addMarker(BuildContext context, Profile profile) async {
    final Uint8List icon = await getBytesFromAssets('assets/images/rider.png', 100);

    Map<Marker, Profile> updatedMarkers = Map.from(state);
    bool markerExists = updatedMarkers.keys.any((marker) => marker.markerId.value == '${profile.userId}');

    if (!markerExists) {
      // If the marker doesn't exist, create a new one
      updatedMarkers[Marker(
        markerId: MarkerId('${profile.userId}'),
        position: profile.location == null
            ? LatLng(0.0, 0.0)
            : LatLng(
          profile.location?.latitude == null ? 0 : profile.location!.latitude!,
          profile.location?.longitude == null ? 0 : profile.location!.longitude!,
        ),
        infoWindow: InfoWindow(
          title: "${profile.name}",
          snippet: "Tap for more details",
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreens(userId: '${profile.userId}')));
          },
        ),
        icon: BitmapDescriptor.fromBytes(icon),
      )] = profile;

      emit(updatedMarkers);
    }
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