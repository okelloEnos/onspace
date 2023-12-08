// import 'package:flutter/material.dart';
//
// class TriangleWidget extends StatelessWidget {
//   final double size;
//   final Color color;
//
//   TriangleWidget({required this.size, required this.color});
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: TrianglePainter(color: color),
//       size: Size(size, size),
//     );
//   }
// }
//
// class TrianglePainter extends CustomPainter {
//   final Color color;
//
//   TrianglePainter({required this.color});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = color
//       ..style = PaintingStyle.fill;
//
//     Path path = Path();
//     path.moveTo(size.width / 2, 0);
//     path.lineTo(0, size.height);
//     path.lineTo(size.width, size.height);
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
//
