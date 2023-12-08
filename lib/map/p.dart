// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
//
//
// class CustomCircle extends StatelessWidget {
//   final String? avatar;
//   const CustomCircle({Key? key, required this.avatar}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Positioned(
//           top: 0,
//           left: 0,
//           right: 0,
//           child: SizedBox(
//             height: 100,
//             width: 100,
//             child: CustomPaint(
//               size: Size(200, 200),
//               painter: CustomCirclePainter(),
//               child: SizedBox(
//                 height: 20,
//                 width: 20,
//                 // child: ClipRRect(
//                 //   borderRadius:
//                 //   BorderRadius.circular(10),
//                 //   child: avatar == null
//                 //       ? Image.asset('assets/images/profile_picture.png', height: 20, width: 20, fit: BoxFit.cover, )
//                 //       : CachedNetworkImage(
//                 //     imageUrl:
//                 //     avatar ?? '',
//                 //     imageBuilder: (context,
//                 //         imageProvider,) =>
//                 //         Container(
//                 //           decoration:
//                 //           BoxDecoration(
//                 //             shape: BoxShape.circle,
//                 //             image:
//                 //             DecorationImage(
//                 //               image:
//                 //               imageProvider,
//                 //               fit: BoxFit.fill,
//                 //             ),
//                 //           ),
//                 //           height: 20,
//                 //           width: 20,
//                 //         ),
//                 //     placeholder:
//                 //         (context, url) =>
//                 //     const CircularProgressIndicator(),
//                 //     errorWidget: (context,
//                 //         url, error,) =>
//                 //         Image.asset('assets/images/profile_picture.png', height: 20, width: 20, fit: BoxFit.cover, ),
//                 //   ),
//                 // ),
//               ),
//             ),
//           ),
//         ),
//         Positioned(
//           top: 10,
//           left: 10,
//           right: 10,
//           child: ClipRRect(
//             borderRadius:
//             BorderRadius.circular(10),
//             child: avatar == null
//                 ? Image.asset('assets/images/profile_picture.png', height: 20, width: 20, fit: BoxFit.cover, )
//                 : CachedNetworkImage(
//               imageUrl:
//               avatar ?? '',
//               imageBuilder: (context,
//                   imageProvider,) =>
//                   Container(
//                     decoration:
//                     BoxDecoration(
//                       shape: BoxShape.circle,
//                       image:
//                       DecorationImage(
//                         image:
//                         imageProvider,
//                         fit: BoxFit.fill,
//                       ),
//                     ),
//                     height: 20,
//                     width: 20,
//                   ),
//               placeholder:
//                   (context, url) =>
//               const CircularProgressIndicator(),
//               errorWidget: (context,
//                   url, error,) =>
//                   Image.asset('assets/images/profile_picture.png', height: 20, width: 20, fit: BoxFit.cover, ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
//
// class CustomCirclePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     double height = size.height;
//     double width = size.width;
//     final paint = Paint()
//       ..color = Colors.red
//       ..style = PaintingStyle.fill;
//
//     final path = Path();
//     path.moveTo(width * 0.25, height * 1);
//     path.quadraticBezierTo(
//         width * 0.1, height * 0.35, width * 0.25, height * 0.05);
//     path.quadraticBezierTo(
//         width * 0.5, -(height * 0.75), width * 0.75, height * 0.05);
//     // path.lineTo(width * 0.75, height * 0.05);
//     path.quadraticBezierTo(
//         width * 0.9, height * 0.35, width * 0.75, height * 0.75);
//
//     path.lineTo(width * 0.4, height * 0.75);
//     path.lineTo(width * 0.25, height);
//     path.moveTo(width * 0.15, height * 0.08);
//
//     canvas.drawPath(path, paint);
//
//     //text to display
//     // String text = "Welcome to the platform that lets you manage your Business like the Boss you are!";
//
//     // TextSpan textSpan = TextSpan(
//     //   text: text,
//     //   style: const TextStyle(
//     //       color: Colors.white, // Text color
//     //       fontFamily: 'Neue',
//     //       fontSize: 20.0,
//     //       fontWeight: FontWeight.w600
//     //   ),
//     // );
//
//     // TextPainter textPainter = TextPainter(
//     //   text: textSpan,
//     //   textAlign: TextAlign.start,  // Text alignment
//     //   textDirection: TextDirection.ltr,
//     // );
//
//     // textPainter.layout(maxWidth: width * 0.55);
//     //
//     //
//     // Offset textOffset = Offset(width * 0.27, height * 0.05);
//     //
//     // textPainter.paint(canvas, textOffset);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }
