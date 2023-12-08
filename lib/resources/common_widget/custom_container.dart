import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.hintColor,
        ),
        shape: BoxShape.circle,
      ),
      child: child,
    );
  }
}
