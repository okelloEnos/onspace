import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({required this.loadingText, super.key});
  final String loadingText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(child: SizedBox(
      height: 100,
      child: Column(
        children: [
          CircularProgressIndicator(
            backgroundColor: theme.colorScheme.secondary,
            color: theme.colorScheme.tertiary,
          ),
          const SizedBox(height: 10,),
          Text(loadingText,
            style: TextStyle(
              color: theme.colorScheme.tertiary,
              fontSize: 14,
              fontFamily: 'Spline',
              fontWeight: FontWeight.w600,
            ),),
        ],
      ),
    ),);
  }
}
