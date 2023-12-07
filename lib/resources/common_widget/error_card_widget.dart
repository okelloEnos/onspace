import 'package:flutter/material.dart';

class ErrorCardWidget extends StatelessWidget {
  const ErrorCardWidget({required this.errorText, required this.retry, super.key});
  final String errorText;
  final VoidCallback retry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
        color: theme.colorScheme.error,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 10, right: 10, top: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(errorText, style: TextStyle(
                color: theme.colorScheme.onError,
                fontSize: 14,
                fontFamily: 'Spline',
                fontWeight: FontWeight.w600,
              ),),
              const SizedBox(height: 40,),
              Center(
                child: ElevatedButton(
                    onPressed: () => retry,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty
                          .all(theme.colorScheme.onError),
                      foregroundColor: MaterialStateProperty
                          .all(theme.colorScheme.error),),
                    child: Text("Retry", style: TextStyle(
                      color: theme.colorScheme.error,
                      fontSize: 14,
                      fontFamily: 'Spline',
                      fontWeight: FontWeight.w600,
                    ),)
                ),
              ),
            ],
          ),
        ));
  }
}
