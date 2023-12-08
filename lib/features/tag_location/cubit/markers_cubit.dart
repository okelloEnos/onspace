import 'dart:async';
import 'dart:io';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onspace/features/profile/ui/screens/profile_screens.dart';
import 'package:onspace/features/tag_location/data/model/profile.dart';
import 'package:onspace/features/tag_location/ui/widgets/custom_marker.dart';

class MarkersCubit extends Cubit<List<MarkerData>> {
  MarkersCubit() : super([]);

  void clearMarkers() {
    emit([]);
  }

  Future<void> addMarker(BuildContext context, Profile profile) async {
    final updatedMarkers = state;
    final markerExists = updatedMarkers
        .any((marker) => marker.marker.markerId.value == '${profile.userId}');

    if (!markerExists) {
      final File markerImageFile =
          await DefaultCacheManager().getSingleFile(profile.avatar ?? '');
      final data = MarkerData(
          marker: Marker(
            markerId: MarkerId('${profile.userId}'),
            position: LatLng(
              profile.location?.latitude == null
                  ? 0
                  : profile.location!.latitude!,
              profile.location?.longitude == null
                  ? 0
                  : profile.location!.longitude!,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfileScreens(
                    profile: profile,
                  ),
                ),
              );
            },
          ),
          child: CustomMapMarker(profile: profile, file: markerImageFile),);

      final newUpd = <MarkerData>[...updatedMarkers, data];
      emit(newUpd);
    }
  }
}
