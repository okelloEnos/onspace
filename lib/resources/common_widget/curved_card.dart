import 'package:flutter/material.dart';

class CurvedCard extends StatelessWidget {
  const CurvedCard({required this.child, required this.color, super.key});
  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurvedTopClipper(),
      child: Card(
        color: color,
        elevation: 0,
        shape: CustomCardShape(),
        child: child,
      ),
    );
  }
}


class CustomCardShape extends RoundedRectangleBorder {

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    const radius = 16.0;

    final path = Path()
      ..moveTo(rect.left + radius, rect.top)
      ..lineTo(rect.right - radius, rect.top)
      ..quadraticBezierTo(rect.right, rect.top, rect.right, rect.top + radius)
      ..lineTo(rect.right, rect.bottom - radius)
      ..quadraticBezierTo(
          rect.right, rect.bottom, rect.right - radius, rect.bottom,)
      ..lineTo(rect.left + radius, rect.bottom)
      ..quadraticBezierTo(rect.left, rect.bottom, rect.left,
          rect.bottom - radius,)
      ..lineTo(rect.left, rect.top + radius)
      ..quadraticBezierTo(rect.left, rect.top, rect.left + radius, rect.top);

    return path;
  }
}


class CurvedTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height)
      ..quadraticBezierTo(
          size.width / 2, size.height - 20, size.width, size.height,)
      ..lineTo(size.width, 0)
    ..quadraticBezierTo(
    size.width / 2, 20, 0, 0,);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
