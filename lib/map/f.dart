// import 'dart:async';
// import 'dart:ui';
//
// import 'package:flutter/services.dart';
// import 'package:flutter_cache_manager/file.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class CustomMarker {
//   static Future<Marker?> buildMarkerFromUrl({
//     required String id,
//     required String url,
//     required LatLng position,
//     int? width,
//     int? height,
//     Offset offset = const Offset(0.5, 0.5),
//     VoidCallback? onTap,
//   }) async {
//     var icon = await getIconFromUrl(
//       url,
//       height: height,
//       width: width,
//     );
//
//     if (icon == null) return null;
//     return Marker(
//       markerId: MarkerId(id),
//       position: position,
//       icon: icon,
//       anchor: offset,
//       onTap: onTap,
//     );
//   }
//
//   static Future<BitmapDescriptor?> getIconFromUrl(String url, {
//     int? width,
//     int? height,
//   }) async {
//     Uint8List? bytes = await getBytesFromUrl(
//         url,
//         height: height,
//         width: width
//     );
//
//     if (bytes == null) return null;
//
//     return BitmapDescriptor.fromBytes(bytes);
//   }
//
//   static Future<Uint8List?> getBytesFromUrl(String url, {
//     int? width,
//     int? height,
//   }) async {
//     // Modify this as needed, but you need caching unless you're displaying just a few markers.
//     var cache = CacheManager(Config(
//       "markers",
//       stalePeriod: const Duration(days: 7),
//     ));
//
//     File file = await cache.getSingleFile(url);
//
//     Uint8List bytes = await file.readAsBytes();
//
//     return resizeImageFromBytes(bytes, width: width, height: height);
//   }
//
//   static Future<Uint8List?> resizeImageFromBytes(Uint8List bytes, {
//     int? width,
//     int? height,
//   }) async {
//     Codec codec = await instantiateImageCodec(
//         bytes,
//         targetWidth: width,
//         targetHeight: height
//     );
//     FrameInfo fi = await codec.getNextFrame();
//     ByteData? data = await fi.image.toByteData(format: ImageByteFormat.png);
//
//     return data?.buffer.asUint8List();
//   }
// }
