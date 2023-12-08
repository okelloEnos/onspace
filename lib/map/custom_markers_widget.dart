// import 'package:flutter/material.dart';
//
//
//
// class ArrowContainer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Arrow Container Example'),
//       ),
//       body: Center(
//         child: ArrowShapeContainer(
//           child: Container(
//             width: 200,
//             height: 100,
//             color: Colors.blue,
//             child: Center(
//               child: Text(
//                 'Your Content Here',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class ArrowShapeContainer extends StatelessWidget {
//   final Widget child;
//
//   ArrowShapeContainer({required this.child});
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: ArrowPainter(),
//       child: child,
//     );
//   }
// }
//
// class ArrowPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()..color = Colors.blue;
//
//     // Draw the container shape
//     final containerPath = Path()
//       ..lineTo(size.width, 0)
//       ..lineTo(size.width, size.height)
//       ..lineTo(size.width / 2 + 20, size.height)
//       ..lineTo(size.width / 2, size.height + 20)
//       ..lineTo(size.width / 2 - 20, size.height)
//       ..lineTo(0, size.height)
//       ..close();
//
//     canvas.drawPath(containerPath, paint);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ArrowContainer(),
//     );
//   }
// }
