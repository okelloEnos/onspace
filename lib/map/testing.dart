// Future<BitmapDescriptor> getMarkerImage(NearbyUsers user) async {
//   if (user.image != null) {
//     final File markerImageFile =
//     await DefaultCacheManager().getSingleFile(user.image);
//
//     Size s = user.userId == profileData.userId.toString()
//         ? Size(150, 150)
//         : Size(120, 120);
//
//     var icon = await getMarkerIcon(markerImageFile.path, s, user);
//     return icon;
//   } else {
//
//     return BitmapDescriptor.defaultMarker;
//   }
// }
//
// Future<BitmapDescriptor> getMarkerIcon(
//     String imagePath, Size size, NearbyUsers user) async {
//   final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
//   final Canvas canvas = Canvas(pictureRecorder);
//
//   final Radius radius = Radius.circular(size.width / 2);
//
//
//   final Paint nameTagPaint = Paint()..color = MyTheme.primaryColor;
//   final double nameTagWidth = 40.0;
//
//   final Paint shadowPaint = Paint()
//     ..color = MyTheme.primaryColor.withAlpha(120);
//   final double shadowWidth = 15.0;
//
//   final Paint borderPaint = Paint()..color = Colors.white;
//   final double borderWidth = 3.0;
//
//   final double imageOffset = shadowWidth + borderWidth;
//
//
//
//   // Add shadow circle
//   canvas.drawRRect(
//       RRect.fromRectAndCorners(
//         Rect.fromLTWH(0.0, 0.0, size.width, size.height),
//         topLeft: radius,
//         topRight: radius,
//         bottomLeft: radius,
//         bottomRight: radius,
//       ),
//       shadowPaint);
//   // Add border circle
//   canvas.drawRRect(
//       RRect.fromRectAndCorners(
//         Rect.fromLTWH(shadowWidth, shadowWidth,
//             size.width - (shadowWidth * 2), size.height - (shadowWidth * 2)),
//         topLeft: radius,
//         topRight: radius,
//         bottomLeft: radius,
//         bottomRight: radius,
//       ),
//       borderPaint);
//
//
//   // Name tag BG
//   canvas.drawRRect(
//       RRect.fromRectAndCorners(
//         Rect.fromCircle(center: Offset(nameTagWidth/2,nameTagWidth/2), radius: size.height *0.4 ),
//         topLeft: Radius.circular(8),
//         topRight:  Radius.circular(8),
//         bottomLeft: Radius.circular(8),
//         bottomRight: Radius.circular(8),
//       ),
//       nameTagPaint);
//
//   // Add Name text
//   TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
//   textPainter.text = TextSpan(
//     text: '${user.fname} ${user.lname}',
//     style: TextStyle(fontSize: 20.0, color: Colors.white),
//   );
//
//   textPainter.layout();
//   textPainter.paint(
//     canvas,
//     Offset(1.0, 1.0),
//     // Offset(size.width - nameTagWidth / 2 - textPainter.width / 2,
//     //     nameTagWidth / 2 - textPainter.height / 2)
//   );
//
//
//   // Oval for the image
//   Rect oval = Rect.fromLTWH(imageOffset, imageOffset,
//       size.width - (imageOffset * 2), size.height - (imageOffset * 2));
//
//   // Add path for oval image
//   canvas.clipPath(Path()..addOval(oval));
//
//
//
//   // Add image
//   ui.Image image = await getImageFromPath(
//       imagePath); // Alternatively use your own method to get the image
//   paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.fitWidth);
//
//   // Convert canvas to image
//   final ui.Image markerAsImage = await pictureRecorder
//       .endRecording()
//       .toImage(size.width.toInt(), size.height.toInt());
//
//   // Convert image to bytes
//   final ByteData byteData =
//   await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
//   final Uint8List uint8List = byteData.buffer.asUint8List();
//
//   return BitmapDescriptor.fromBytes(uint8List);
// }
//
// Future<ui.Image> getImageFromPath(String imagePath) async {
//   File imageFile = File(imagePath);
//
//   Uint8List imageBytes = imageFile.readAsBytesSync();
//
//   final Completer<ui.Image> completer = new Completer();
//
//   ui.decodeImageFromList(imageBytes, (ui.Image img) {
//     return completer.complete(img);
//   });
//
//   return completer.future;
// }
//
