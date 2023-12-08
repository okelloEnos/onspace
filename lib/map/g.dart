import 'package:flutter/material.dart';
import 'package:onspace/map/p.dart';
import 'package:onspace/resources/common_widget/circular_button_widget.dart';

class PointerWidget extends StatelessWidget {
  const PointerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // CustomCircle(avatar: ,),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 0.0),
          child: CircularIconButton(child: Icon(Icons.home, color: theme.colorScheme.secondary,), containerColor: theme.colorScheme.tertiary,),
        )
      ],
    );
  }
}
