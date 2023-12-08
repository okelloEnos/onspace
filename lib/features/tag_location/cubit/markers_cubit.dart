import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:custom_marker/marker_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onspace/features/profile/ui/screens/profile_screens.dart';
import 'package:onspace/features/tag_location/data/model/profile.dart';
import 'package:onspace/resources/common_widget/circular_button_widget.dart';

import '../ui/widgets/custom_marker.dart';
// final GlobalKey globalKey1 = GlobalKey();
class MarkersCubit extends Cubit<List<MarkerData>> {

  MarkersCubit() : super([]);

  void clearMarkers() {
    emit([]);
  }

  Future<void> addMarker(BuildContext context, Profile profile) async {
    final Uint8List icon = await getBytesFromAssets('assets/images/rider.png', 100);

    List<MarkerData> updatedMarkers = state;
    // bool markerExists = updatedMarkers.keys.any((marker) => marker.markerId.value == '${profile.userId}');
    bool markerExists = updatedMarkers.any((marker) => marker.marker.markerId.value == '${profile.userId}');

    if (!markerExists) {
      final File markerImageFile =
      await DefaultCacheManager().getSingleFile(profile.avatar ?? '');
      var data = MarkerData(
        marker:
        Marker(
          markerId: MarkerId('${profile.userId}'),
            position: LatLng(
              profile.location?.latitude == null ? 0 : profile.location!.latitude!,
              profile.location?.longitude == null ? 0 : profile.location!.longitude!,
            ),
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProfileScreens(profile: profile,
            ),),);
        },
        ),
          child: CustomMapMarker(profile: profile, file: markerImageFile));

      List<MarkerData> newUpd = [...updatedMarkers, data];
      emit(newUpd);
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

Future<BitmapDescriptor> getMarkerIcon(String image, String name) async {
  if (image != null) {
    final File markerImageFile =
    await DefaultCacheManager().getSingleFile(image);
    Size s = Size(120, 120);

    var icon = await createCustomMarkerBitmapWithNameAndImage(markerImageFile.path, s, name);

    return icon;
  } else {
    return BitmapDescriptor.defaultMarker;
  }
}

Future<BitmapDescriptor> createCustomMarkerBitmapWithNameAndImage1(
    String imagePath, Size size, String name) async {


  TextSpan span = new TextSpan(
      style: new TextStyle(
        height: 1.2,
        color: Colors.black,
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
      text: name);
  TextPainter tp = new TextPainter(
    text: span,
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );
  tp.layout();

  ui.PictureRecorder recorder = new ui.PictureRecorder();
  Canvas canvas = new Canvas(recorder);

  final double shadowWidth = 15.0;
  final double borderWidth = 3.0;
  final double imageOffset = shadowWidth + borderWidth;


  final Radius radius = Radius.circular(size.width / 2);

  final Paint shadowCirclePaint = Paint()
    ..color = Colors.red.withAlpha(180);

  // Add shadow circle
  canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(
            size.width / 8, size.width / 2, size.width, size.height),
        topLeft: radius,
        topRight: radius,
        bottomLeft: radius,
        bottomRight: radius,
      ),
      shadowCirclePaint);
  // TEXT BOX BACKGROUND
  Paint textBgBoxPaint = Paint()..color = Colors.red;

  Rect rect = Rect.fromLTWH(
    0,
    0,
    tp.width + 35,
    50,
  );

  canvas.drawRRect(
    RRect.fromRectAndRadius(rect, Radius.circular(10.0)),
    textBgBoxPaint,
  );

  //ADD TEXT WITH ALIGN TO CANVAS
  tp.paint(canvas, new Offset(20.0, 5.0));

  /* Do your painting of the custom icon here, including drawing text, shapes, etc. */

  Rect oval = Rect.fromLTWH(35, 78, size.width - (imageOffset * 2),
      size.height - (imageOffset * 2));


  // ADD  PATH TO OVAL IMAGE
  canvas.clipPath(Path()..addOval(oval));
  ui.Image image = await getImageFromPath(
      imagePath);
  paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.fitWidth);

  ui.Picture p = recorder.endRecording();
  ByteData? pngBytes = await (await p.toImage(300, 300))
      .toByteData(format: ui.ImageByteFormat.png);

  Uint8List data = Uint8List.view(pngBytes!.buffer);

  return BitmapDescriptor.fromBytes(data);
}

Future<ui.Image> getImageFromPath(String imagePath) async {
  File imageFile = File(imagePath);

  Uint8List imageBytes = imageFile.readAsBytesSync();

  final Completer<ui.Image> completer = new Completer();

  ui.decodeImageFromList(imageBytes, (ui.Image img) {
    return completer.complete(img);
  });

  return completer.future;
}

Future<BitmapDescriptor> createCustomMarkerBitmapWithNameAndImage2(
    String imagePath, Size size, String name) async {

  try {
    TextSpan span = TextSpan(
      style: TextStyle(
        height: 1.2,
        color: Colors.black,
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
      text: name,
    );

    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();

    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);

    final double shadowWidth = 15.0;
    final double borderWidth = 3.0;
    final double imageOffset = shadowWidth + borderWidth;

    final Radius radius = Radius.circular(size.width / 2);

    final Paint shadowCirclePaint = Paint()
      ..color = Colors.red.withAlpha(180);

    // Add shadow circle
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(
            size.width / 8, size.width / 2, size.width, size.height),
        topLeft: radius,
        topRight: radius,
        bottomLeft: radius,
        bottomRight: radius,
      ),
      shadowCirclePaint,
    );

    // TEXT BOX BACKGROUND
    Paint textBgBoxPaint = Paint()..color = Colors.red;

    Rect rect = Rect.fromLTWH(
      0,
      0,
      tp.width + 35,
      50,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(10.0)),
      textBgBoxPaint,
    );

    // ADD TEXT WITH ALIGN TO CANVAS
    tp.paint(canvas, Offset(20.0, 5.0));

    /* Do your painting of the custom icon here, including drawing text, shapes, etc. */

    Rect oval = Rect.fromLTWH(35, 78, size.width - (imageOffset * 2),
        size.height - (imageOffset * 2));

    // ADD PATH TO OVAL IMAGE
    canvas.clipPath(Path()..addOval(oval));

    ui.Image image = await getImageFromPath(imagePath);

    if (image != null) {
      paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.fitWidth);
    }

    ui.Picture p = recorder.endRecording();
    ByteData? pngBytes = await (await p.toImage(300, 300))
        .toByteData(format: ui.ImageByteFormat.png);

    Uint8List data = Uint8List.view(pngBytes!.buffer);

    return BitmapDescriptor.fromBytes(data);
  } catch (e) {
    print('Error creating custom marker: $e');
    // Handle error appropriately, e.g., return a default marker
    return BitmapDescriptor.defaultMarker;
  }
}

Future<BitmapDescriptor> createCustomMarkerBitmapWithNameAndImageq(
    String imagePath, Size size, String name) async {
  try {
    TextSpan span = TextSpan(
      style: TextStyle(
        height: 1.2,
        color: Colors.black,
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
      text: name,
    );

    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();

    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);

    final double shadowWidth = 15.0;
    final double borderWidth = 3.0;
    final double imageOffset = shadowWidth + borderWidth;

    final Radius radius = Radius.circular(size.width / 2);

    final Paint shadowCirclePaint = Paint()
      ..color = Colors.red.withAlpha(180);

    // Draw the shadow with a pointy end extension
    Path shadowPath = Path()
      ..moveTo(size.width / 2, size.height)
      ..lineTo(size.width / 2 - 15, size.height + 30) // Pointy end
      ..lineTo(size.width / 2 + 15, size.height + 30) // Pointy end
      ..close();

    canvas.drawPath(shadowPath, shadowCirclePaint);

    // Draw the rounded rectangle for the text box background
    Paint textBgBoxPaint = Paint()..color = Colors.red;
    Rect rect = Rect.fromLTWH(0, 0, tp.width + 35, 50);
    canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(10.0)), textBgBoxPaint);

    // Draw the text
    tp.paint(canvas, Offset(20.0, 5.0));

    // Draw the oval image
    Rect oval = Rect.fromLTWH(35, 78, size.width - (imageOffset * 2), size.height - (imageOffset * 2));
    canvas.clipPath(Path()..addOval(oval));
    ui.Image image = await getImageFromPath(imagePath);

    if (image != null) {
      paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.fitWidth);
    }

    ui.Picture p = recorder.endRecording();
    ByteData? pngBytes = await (await p.toImage(300, 300)).toByteData(format: ui.ImageByteFormat.png);

    Uint8List data = Uint8List.view(pngBytes!.buffer);

    return BitmapDescriptor.fromBytes(data);
  } catch (e) {
    print('Error creating custom marker: $e');
    // Handle error appropriately, e.g., return a default marker
    return BitmapDescriptor.defaultMarker;
  }
}

Future<BitmapDescriptor> createCustomMarkerBitmapWithNameAndImage3(
    String imagePath, Size size, String name) async {
  try {
    TextSpan span = TextSpan(
      style: TextStyle(
        height: 1.2,
        color: Colors.black,
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
      text: name,
    );

    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();

    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);

    final double shadowWidth = 15.0;
    final double borderWidth = 3.0;
    final double imageOffset = shadowWidth + borderWidth;

    final Radius radius = Radius.circular(size.width / 2);

    final Paint shadowCirclePaint = Paint()
      ..color = Colors.red.withAlpha(180);

    // Add shadow circle
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(
            size.width / 8, size.width / 2, size.width, size.height),
        topLeft: radius,
        topRight: radius,
        bottomLeft: radius,
        bottomRight: radius,
      ),
      // paintShadow
      shadowCirclePaint,
    );

    // TEXT BOX BACKGROUND
    Paint textBgBoxPaint = Paint()..color = Colors.red;

    Rect rect = Rect.fromLTWH(
      0,
      0,
      tp.width + 35,
      50,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(10.0)),
      textBgBoxPaint,
    );

    // ADD TEXT WITH ALIGN TO CANVAS
    tp.paint(canvas, Offset(20.0, 5.0));

    // // ADD TRIANGLE POINTING DOWN
    // Paint trianglePaint = Paint()..color = Colors.blue;
    // Path path = Path()
    //   ..moveTo(size.width / 2 - 15, size.height)
    //   ..lineTo(size.width / 2 + 15, size.height)
    //   ..lineTo(size.width / 2, size.height + 30)
    //   ..close();
    //
    // canvas.drawPath(path, trianglePaint);

    /* Do your painting of the custom icon here, including drawing text, shapes, etc. */

    Rect oval = Rect.fromLTWH(35, 78, size.width - (imageOffset * 2),
        size.height - (imageOffset * 2));

    // ADD PATH TO OVAL IMAGE
    canvas.clipPath(Path()..addOval(oval));

    // // ADD TRIANGLE POINTING DOWN
    // Paint trianglePaint = Paint()..color = Colors.blue;
    // Path pathq = Path()
    //   ..moveTo(size.width / 2 - 15, size.height)
    //   ..lineTo(size.width / 2 + 15, size.height)
    //   ..lineTo(size.width / 2, size.height + 30)
    //   ..close();
    //
    // canvas.drawPath(pathq, trianglePaint);

    ui.Image image = await getImageFromPath(imagePath);

    if (image != null) {
      paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.fitWidth);
    }

    ui.Picture p = recorder.endRecording();
    ByteData? pngBytes = await (await p.toImage(300, 300))
        .toByteData(format: ui.ImageByteFormat.png);

    Uint8List data = Uint8List.view(pngBytes!.buffer);

    return BitmapDescriptor.fromBytes(data);
  } catch (e) {
    print('Error creating custom marker: $e');
    // Handle error appropriately, e.g., return a default marker
    return BitmapDescriptor.defaultMarker;
  }
}

// Future<BitmapDescriptor> createCustomMarkerBitmapWithNameAndImage(
//     String imagePath, Size size, String name) async {
//   try {
//     TextSpan span = TextSpan(
//       style: TextStyle(
//         height: 1.2,
//         color: Colors.black,
//         fontSize: 30.0,
//         fontWeight: FontWeight.bold,
//       ),
//       text: name,
//     );
//
//     TextPainter tp = TextPainter(
//       text: span,
//       textAlign: TextAlign.center,
//       textDirection: TextDirection.ltr,
//     );
//     tp.layout();
//
//     ui.PictureRecorder recorder = ui.PictureRecorder();
//     Canvas canvas = Canvas(recorder);
//
//     final double shadowWidth = 15.0;
//     final double borderWidth = 3.0;
//     final double imageOffset = shadowWidth + borderWidth;
//
//     final double centerX = size.width / 2;
//     final double centerY = size.height - imageOffset;
//
//     final Radius radius = Radius.circular(size.width / 2);
//
//     final Paint shadowCirclePaint = Paint()
//       ..color = Colors.red.withAlpha(180);
//
//     // Add shadow circle
//     canvas.drawRRect(
//       RRect.fromRectAndCorners(
//         Rect.fromLTWH(centerX - size.width / 2, centerY - size.height / 2, size.width, size.height),
//         topLeft: radius,
//         topRight: radius,
//         bottomLeft: radius,
//         bottomRight: radius,
//       ),
//       shadowCirclePaint,
//     );
//
//     // TEXT BOX BACKGROUND
//     Paint textBgBoxPaint = Paint()..color = Colors.red;
//
//     Rect rect = Rect.fromLTWH(
//       centerX - (tp.width + 35) / 2,
//       centerY + imageOffset,
//       tp.width + 35,
//       50,
//     );
//
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(rect, Radius.circular(10.0)),
//       textBgBoxPaint,
//     );
//
//     // ADD TEXT WITH ALIGN TO CANVAS
//     tp.paint(canvas, Offset(centerX - tp.width / 2, centerY + imageOffset + 45.0));
//
//     // ADD PATH TO OVAL IMAGE
//     Rect oval = Rect.fromLTWH(centerX - size.width / 2, centerY - size.height / 2, size.width, size.height);
//     canvas.clipPath(Path()..addOval(oval));
//     double height = size.height;
//     double width = size.width;
//     final paint = Paint()
//       ..color = Colors.blue
//       ..style = PaintingStyle.fill;
//
//     final path = Path();
//     path.moveTo(width * 0.25, height * 0.75);
//     path.quadraticBezierTo(
//         width * 0.1, height * 0.35, width * 0.25, height * 0.05);
//     path.lineTo(width * 0.75, height * 0.05);
//     path.quadraticBezierTo(
//         width * 0.9, height * 0.35, width * 0.75, height * 0.75);
//
//     path.lineTo(width * 0.4, height * 0.75);
//     path.lineTo(width * 0.25, height);
//     path.moveTo(width * 0.15, height * 0.08);
//
//     canvas.drawPath(path, paint);
//
//
//     ui.Image image = await getImageFromPath(imagePath);
//
//     if (image != null) {
//       paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.fitWidth);
//     }
//
//     ui.Picture p = recorder.endRecording();
//     ByteData? pngBytes = await (await p.toImage(300, 300))
//         .toByteData(format: ui.ImageByteFormat.png);
//
//     Uint8List data = Uint8List.view(pngBytes!.buffer);
//
//     return BitmapDescriptor.fromBytes(data);
//   } catch (e) {
//     print('Error creating custom marker: $e');
//     // Handle error appropriately, e.g., return a default marker
//     return BitmapDescriptor.defaultMarker;
//   }
// }

Future<BitmapDescriptor> createCustomMarkerBitmapWithNameAndImage(
    String imagePath, Size size, String name) async {
  try {
    TextSpan span = TextSpan(
      style: TextStyle(
        height: 1.2,
        color: Colors.black,
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
      text: name,
    );

    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();

    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);

    final double shadowWidth = 15.0;
    final double borderWidth = 3.0;
    final double imageOffset = shadowWidth + borderWidth;

    final double centerX = size.width / 2;
    final double centerY = size.height - imageOffset;

    final Radius radius = Radius.circular(size.width / 2);

    final Paint shadowCirclePaint = Paint()
      ..color = Colors.red.withAlpha(180);

    // Add shadow circle
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(centerX - size.width / 2, centerY - size.height / 2, size.width, size.height),
        topLeft: radius,
        topRight: radius,
        bottomLeft: radius,
        bottomRight: radius,
      ),
      shadowCirclePaint,
    );

    // TEXT BOX BACKGROUND
    Paint textBgBoxPaint = Paint()..color = Colors.red;

    Rect rect = Rect.fromLTWH(
      centerX - (tp.width + 35) / 2,
      centerY + imageOffset,
      tp.width + 35,
      50,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(10.0)),
      textBgBoxPaint,
    );

    // ADD TEXT WITH ALIGN TO CANVAS
    tp.paint(canvas, Offset(centerX - tp.width / 2, centerY + imageOffset + 45.0));

    // ADD PATH TO OVAL IMAGE
    Rect oval = Rect.fromLTWH(centerX - size.width / 2, centerY - size.height / 2, size.width, size.height);
    canvas.clipPath(Path()..addOval(oval));
    double height = size.height;
    double width = size.width;
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(width * 0.25, height * 0.75);
    path.quadraticBezierTo(
        width * 0.1, height * 0.35, width * 0.25, height * 0.05);
    path.lineTo(width * 0.75, height * 0.05);
    path.quadraticBezierTo(
        width * 0.9, height * 0.35, width * 0.75, height * 0.75);

    path.lineTo(width * 0.4, height * 0.75);
    path.lineTo(width * 0.25, height);
    path.moveTo(width * 0.15, height * 0.08);

    canvas.drawPath(path, paint);


    ui.Image image = await getImageFromPath(imagePath);

    if (image != null) {
      paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.fitWidth);
    }

    ui.Picture p = recorder.endRecording();
    ByteData? pngBytes = await (await p.toImage(300, 300))
        .toByteData(format: ui.ImageByteFormat.png);

    Uint8List data = Uint8List.view(pngBytes!.buffer);

    return BitmapDescriptor.fromBytes(data);
  } catch (e) {
    print('Error creating custom marker: $e');
    // Handle error appropriately, e.g., return a default marker
    return BitmapDescriptor.defaultMarker;
  }
}






