// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'f.dart';
//
// class MapWithCustomMarkers extends StatefulWidget {
//   @override
//   _MapWithCustomMarkersState createState() => _MapWithCustomMarkersState();
// }
//
// class _MapWithCustomMarkersState extends State<MapWithCustomMarkers> {
//   final Set<Marker> _markers = {};
//
//   @override
//   void initState() {
//     super.initState();
//     _loadMarkers();
//   }
//
//   Future<void> _loadMarkers() async {
//     // Replace 'locations' with your list of locations containing image URLs
//     List<Location> locations = [
//       Location(id: '1',
//           name: 'Location 1',
//           imageUrl: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
//           latitude: 37.7749,
//           longitude: -122.4194),
//       Location(id: '2',
//           name: 'Location 2',
//           imageUrl: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
//           latitude: 37.6841,
//           longitude: -122.4109),
//       // Add more locations as needed
//     ];
//     List<Marker> customMarkers = [];
//
//     for (Location location in locations) {
//       Marker? marker = await CustomMarker.buildMarkerFromUrl(
//         id: location.id,
//         url: location.imageUrl,
//         position: LatLng(location.latitude, location.longitude),
//         width: 100,
//         onTap: () {
//           // Handle marker tap event here
//         },
//       );
//       if (marker != null) {
//         customMarkers.add(marker);
//       }
//       //    await Future.wait(
//       //       locations.map(
//       //       (location) async => await CustomMarker.buildMarkerFromUrl(
//       //       id: location.id,
//       //       url: location.imageUrl,
//       //       position: LatLng(location.latitude, location.longitude),
//       //   width: 100,
//       //   onTap: () {
//       //   // Handle marker tap event here
//       // },
//       //       ),
//       //       ),
//       //   );
//
//       setState(() {
//         _markers.addAll(customMarkers.where((marker) => marker != null));
//       });
//     }
//   }
//
//     @override
//     Widget build(BuildContext context) {
//       return GoogleMap(
//         initialCameraPosition: CameraPosition(
//           target: LatLng(37.7749, -122.4194),
//           zoom: 12,
//         ),
//         markers: _markers,
//       );
//     }
//   }
//
// class Location {
//   final String id;
//   final String name;
//   final String imageUrl;
//   final double latitude;
//   final double longitude;
//
//   Location({
//     required this.id,
//     required this.name,
//     required this.imageUrl,
//     required this.latitude,
//     required this.longitude,
//   });
// }
