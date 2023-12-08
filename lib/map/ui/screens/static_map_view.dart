import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class StaticMapView extends StatefulWidget {
  const StaticMapView({super.key});
  @override
  State<StaticMapView> createState() => StaticMapViewState();
}

class StaticMapViewState extends State<StaticMapView> {
  final Completer<GoogleMapController> _controller = Completer();

  LocationData? currentLocation;

  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  void setCustomMarkerIcon() {
    ///current location icon
    getBytesFromAssets('assets/images/rider.png', 100).then(
      (markerIcon) => {
        currentLocationIcon = BitmapDescriptor.fromBytes(markerIcon),
      },
    );

    setState(() {});
  }

  Future<void> getCurrentLocation() async {
    final location = Location();
    await location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );
    final googleMapController = await _controller.future;
    location.onLocationChanged.listen(
      (newLoc) {
        const tokenValue = 'sharedPreferences.getString(token)';
        final currLatitude = newLoc.latitude;
        final currLongitude = newLoc.longitude;

        if (currLatitude != null && currLongitude != null) {
          Future.delayed(Duration.zero, () {
            currentLocation = newLoc;
            googleMapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  zoom: 13.5,
                  target: LatLng(
                    newLoc.latitude!,
                    newLoc.longitude!,
                  ),
                ),
              ),
            );
          });
        }
      },
    );
  }

  @override
  void initState() {
    // double latitude = "sharedPreferences.getDouble("latitude") ?? 0";
    // double longitude = sharedPreferences.getDouble("longitude") ?? 0;
    const latitude = 0;
    const longitude = 0;
    currentLocation = LocationData.fromMap({
      'latitude': latitude,
      'longitude': longitude,
    });
    setCustomMarkerIcon();
    getCurrentLocation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLocation == null
          ? const Center(child: Text('Loading'))
          : GoogleMap(
              zoomControlsEnabled: false,
              initialCameraPosition: currentLocation == null
                  ? const CameraPosition(target: LatLng(0, 0), zoom: 10)
                  : CameraPosition(
                      target: LatLng(
                        currentLocation!.latitude!,
                        currentLocation!.longitude!,
                      ),
                      zoom: 13.5,
                    ),
              markers: currentLocation != null
                  ? {
                      Marker(
                        markerId: const MarkerId('currentLocation'),
                        icon: currentLocationIcon,
                        position: LatLng(
                          currentLocation!.latitude!,
                          currentLocation!.longitude!,
                        ),
                      ),
                    }
                  : {},
              onMapCreated: (mapController) {
                _controller.complete(mapController);
                setState(() {});
              },
            ),
    );
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
