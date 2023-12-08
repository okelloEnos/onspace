// import 'package:custom_marker/marker_icon.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:onspace/features/tag_location/data/model/profile.dart';
// import 'package:onspace/map/g.dart';
// import 'package:onspace/map/p.dart';
// import 'package:onspace/resources/common_widget/circular_button_widget.dart';
//
// import 'TR.dart';
//
// class WidgetToMarker extends StatefulWidget {
//   const WidgetToMarker({Key? key}) : super(key: key);
//   @override
//   _WidgetToMarkerState createState() => _WidgetToMarkerState();
// }
// class _WidgetToMarkerState extends State<WidgetToMarker> {
//
//   Set<Marker> _markers = <Marker>{};
//
//   // declare a global key
//   final GlobalKey globalKey = GlobalKey();
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Scaffold(
//           body: Stack(
//             children: [
//
//               // you have to add your widget in the same widget tree
//               // add your google map in stack
//               // declare your marker before google map
//               // pass your global key to your widget
//
//               // MyMarker(globalKey, ),
//
//               Positioned.fill(
//                 child: GoogleMap(
//                   initialCameraPosition: CameraPosition(
//                       target: LatLng(32.4279, 53.6880), zoom: 15),
//                   markers: _markers,
//                 ),
//               ),
//             ],
//           ),
//           floatingActionButton: FloatingActionButton.extended(
//             label: FittedBox(child: Text('Add Markers')),
//             onPressed: () async {
//
//               // call widgetToIcon Function and pass the same global key
//
//               _markers.add(
//                 Marker(
//                   markerId: MarkerId('circleCanvasWithText'),
//                   icon: await MarkerIcon.widgetToIcon(globalKey),
//                   position: LatLng(35.8400, 50.9391),
//                 ),
//               );
//               setState(() {});
//             },
//           ),
//           floatingActionButtonLocation:
//           FloatingActionButtonLocation.centerFloat,
//         ),
//       ],
//     );
//   }
// }
//
// class MyMarker extends StatelessWidget {
//   // declare a global key and get it trough Constructor
//
//   MyMarker(this.globalKeyMyWidget);
//   final GlobalKey globalKeyMyWidget;
//
//   @override
//   Widget build(BuildContext context) {
//     // wrap your widget with RepaintBoundary and
//     // pass your global key to RepaintBoundary
//     return RepaintBoundary(
//       key: globalKeyMyWidget,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
// PointerWidget()
//         ],
//       ),
//     );
//   }
// }
//
// class TrianglePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = Colors.black
//       ..style = PaintingStyle.fill;
//
//     Path path = Path();
//     path.moveTo(size.width / 2, size.height);
//     path.lineTo(size.width / 2 - 50, size.height + 20); // Adjust the size of the triangle
//     path.lineTo(size.width / 2 + 20, size.height + 20); // Adjust the size of the triangle
//     path.close();
//
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }
