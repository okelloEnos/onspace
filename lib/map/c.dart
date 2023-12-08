// import 'package:flutter/material.dart';
//
// class PointyCircularPainter extends CustomPainter {
//   final double radius;
//   final Color color;
//
//   PointyCircularPainter({required this.radius, required this.color});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()..color = color;
//
//     double centerX = size.width / 2;
//     double centerY = size.height - radius;
//
//     // Create a circular path
//     Path path = Path()
//       ..addOval(Rect.fromCircle(center: Offset(centerX, centerY), radius: radius));
//
//     // Add a triangle shape at the bottom
//     path.moveTo(centerX - 15, size.height);
//     path.lineTo(centerX + 15, size.height);
//     path.lineTo(centerX, size.height + 30);
//     path.close();
//
//     // Draw the path
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }
//
// class PointyCircularWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: CustomPaint(
//         painter: PointyCircularPainter(radius: 50, color: Colors.blue),
//         child: Container(
//           width: 100,
//           height: 160,
//           // Your content goes here
//           child: Center(
//             child: Text(
//               'Pointy Circular',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
