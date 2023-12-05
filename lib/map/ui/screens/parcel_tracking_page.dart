// import 'dart:async';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:tracker/home/data/model/active_request.dart';
// import 'package:tracker/main.dart';
// import 'package:tracker/resources/resources.dart';
// import 'package:tracker/secrets.dart';
// class ParcelTrackingPage extends StatefulWidget {
//   final LatLng pickUpLocation;
//   final LatLng deliveryLocation;
//   final int hasStop;
//   final Stops deliveryStop;
//
//   const ParcelTrackingPage({Key? key, required this.pickUpLocation, required this.deliveryLocation, required this.hasStop, required this.deliveryStop}) : super(key: key);
//   @override
//   State<ParcelTrackingPage> createState() => ParcelTrackingPageState();
// }
// class ParcelTrackingPageState extends State<ParcelTrackingPage> {
//   final Completer<GoogleMapController> _controller = Completer();
//
//   List<LatLng> polylineCoordinates = [];
// LatLng? sourceLocation, destinationLocation ;
//   LocationData? currentLocation;
//   List<LatLng> stopsGeoPoints = [];
//
//
//   BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
//   BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
//   BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
//   BitmapDescriptor stopIcon = BitmapDescriptor.defaultMarker;
//
//   void setCustomMarkerIcon() {
//
//     ///current location icon
//     getBytesFromAssets("assets/images/rider.png", 100).then((markerIcon) => {
//       currentLocationIcon = BitmapDescriptor.fromBytes(markerIcon)
//     });
//
//     /// source location icon
//     getBytesFromAssets("assets/images/pickup_shop.png", 60).then((markerIcon) => {
//       sourceIcon = BitmapDescriptor.fromBytes(markerIcon)
//     });
//
//     /// destination icon
//     getBytesFromAssets("assets/images/delivery.png", 100).then((markerIcon) => {
//       destinationIcon = BitmapDescriptor.fromBytes(markerIcon)
//     });
//
//     /// stops location icon
//     getBytesFromAssets("assets/images/stop.png", 100).then((markerIcon) => {
//       stopIcon = BitmapDescriptor.fromBytes(markerIcon)
//     });
//   }
//
//   void getCurrentLocation() async {
//     Location location = Location();
//     location.getLocation().then(
//           (location) {
//         currentLocation = location;
//       },
//     );
//     GoogleMapController googleMapController = await _controller.future;
//     location.onLocationChanged.listen(
//           (newLoc) {
//         currentLocation = newLoc;
//         googleMapController.animateCamera(
//           CameraUpdate.newCameraPosition(
//             CameraPosition(
//               zoom: 13.5,
//               target: LatLng(
//                 newLoc.latitude!,
//                 newLoc.longitude!,
//               ),
//             ),
//           ),
//         );
//         setState(() {});
//       },
//     );
//   }
//
//   void getPolyPoints({required LatLng source, required LatLng destination}) async {
//     List<PolylineWayPoint> stopOvers = [];
//    for(LatLng wayGeo in stopsGeoPoints){
//      PolylineWayPoint point = PolylineWayPoint(location: "${wayGeo.latitude},${wayGeo.longitude}", stopOver: true);
//      stopOvers.add(point);
//    }
//     // PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//     //     googleAPiKey,
//     //     PointLatLng(48.696985, -122.905595),
//     //     PointLatLng(48.644983, -122.944760),
//     //     wayPoints: [PolylineWayPoint(location: "48.657421,-122.917412")]);
//     PolylinePoints polylinePoints = PolylinePoints();
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       Secrets.API_KEY, // Your Google Map Key
//       PointLatLng(source.latitude, source.longitude),
//       PointLatLng(destination.latitude, destination.longitude),
//       wayPoints: stopOvers
//     );
//     if (result.points.isNotEmpty) {
//       result.points.forEach(
//             (PointLatLng point) => polylineCoordinates.add(
//           LatLng(point.latitude, point.longitude),
//         ),
//       );
//       setState(() {});
//     }
//   }
//
//   void getStopsLocations({required Stops deliveryStops}){
//     List<String> stopsAddress = deliveryStops.addresses ?? [];
//     List<String> stopsLatitudes = deliveryStops.latitudes ?? [];
//     List<String> stopsLongitudes = deliveryStops.longitudes ?? [];
//
//     for(String stopGeoPoint in stopsAddress){
//       int indexGeo = stopsAddress.indexOf(stopGeoPoint);
//       String stopGeoLatitudeString = stopsLatitudes[indexGeo];
//       String stopGeoLongitudeString = stopsLongitudes[indexGeo];
//       double stopGeoLatitude = double.tryParse(stopGeoLatitudeString) ?? 0.0;
//       double stopGeoLongitude = double.tryParse(stopGeoLongitudeString) ?? 0.0;
//       stopsGeoPoints.add(LatLng(
//           stopGeoLatitude,
//           stopGeoLongitude));
//     }
//   }
//
//   @override
//   void initState() {
//     double latitude = sharedPreferences.getDouble("latitude") ?? 0;
//     double longitude = sharedPreferences.getDouble("longitude") ?? 0;
//     currentLocation = LocationData.fromMap({
//       "latitude": latitude,
//       "longitude": longitude
//     });
//     sourceLocation = widget.pickUpLocation;
//     destinationLocation = widget.deliveryLocation;
//     getStopsLocations(deliveryStops: widget.deliveryStop);
//     if(sourceLocation != null && destinationLocation != null){
//       getPolyPoints(source: sourceLocation!, destination: destinationLocation!);
//     }
//     getCurrentLocation();
//     setCustomMarkerIcon();
//
//     super.initState();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: currentLocation == null
//           ? const Center(child: Text("Loading")) : GoogleMap(
//         zoomControlsEnabled: false,
//         initialCameraPosition:  currentLocation == null
//             ?  const CameraPosition(target: LatLng(0.0, 0.0), zoom: 10.0) : CameraPosition(
//           target: LatLng(
//               currentLocation!.latitude!, currentLocation!.longitude!),
//           zoom: 13.5,
//         ),
//         markers: sourceLocation != null && destinationLocation != null && currentLocation != null ? {
//           Marker(
//             markerId: const MarkerId("currentLocation"),
//             icon: currentLocationIcon,
//             position: LatLng(
//                 currentLocation!.latitude!, currentLocation!.longitude!),
//           ),
//            Marker(
//             markerId: const MarkerId("source"),
//             icon: sourceIcon,
//             position: sourceLocation!,
//           ),
//           Marker(
//             markerId: const MarkerId("destination"),
//             icon: destinationIcon,
//             position: destinationLocation!,
//           ),
//           for(LatLng stopPoint in stopsGeoPoints)
//             Marker(
//               markerId: MarkerId("stop${stopsGeoPoints.indexOf(stopPoint)}"),
//               icon: stopIcon,
//               position: stopPoint,
//             ),
//         } :
//         {
//           // Marker(
//           //   markerId: const MarkerId("currentLocation"),
//           //   icon: currentLocationIcon,
//           //   position: LatLng(
//           //       currentLocation!.latitude!, currentLocation!.longitude!),
//           // ),
//           // Marker(
//           //   markerId: const MarkerId("source"),
//           //   icon: sourceIcon,
//           //   position: sourceLocation!,
//           // ),
//           // Marker(
//           //   markerId: const MarkerId("destination"),
//           //   icon: destinationIcon,
//           //   position: destinationLocation!,
//           // ),
//         },
//         onMapCreated: (mapController) {
//           _controller.complete(mapController);
//         },
//         polylines: {
//           Polyline(
//             polylineId: const PolylineId("route"),
//             points: polylineCoordinates,
//             color: const Color(primaryColor),
//             width: 6,
//           ),
//         },
//       ),
//     );
//   }
//
// }
//
// Future<Uint8List> getBytesFromAssets(String path, int width) async {
//   ByteData data = await rootBundle.load(path);
//   ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
//       targetWidth: width);
//   ui.FrameInfo fi = await codec.getNextFrame();
//   return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
//       .buffer
//       .asUint8List();
// }
