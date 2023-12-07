import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  final Widget child;
  final double? iconSize;
  final Color? iconColor;
  final Color? containerColor;
  final double? containerSize;
  final double? shadowBlur;
  final double? shadowSpread;

  CircularIconButton({
    required this.child,
    this.iconSize ,
    this.iconColor,
    this.containerColor,
    this.containerSize,
    this.shadowBlur,
    this.shadowSpread,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: containerSize ?? 50,
      height: containerSize ?? 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: containerColor ?? theme.colorScheme.secondary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: shadowBlur ?? 1.0,
            spreadRadius: shadowSpread ?? 3.0,
          ),
        ],
      ),
      child: Center(
        child: child,
      ),
    );
  }
}

