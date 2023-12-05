import 'package:flutter/material.dart';

class MenuOptionWidget extends StatelessWidget {
  final VoidCallback onTap;
  final bool? showDivider;
  final String title;
  final String assetName;
  const MenuOptionWidget({super.key, required this.onTap, required this.showDivider, required this.title, required this.assetName});

  @override
  Widget build(BuildContext context) {

    var theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/$assetName', height: 25.0, color: theme.colorScheme.primary, width: 25.0),
                  ),
                ),
                const SizedBox(width: 15.0),
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.labelMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
        (showDivider != null && showDivider!) ? const Divider(
          thickness: 1,
        ) : const SizedBox.shrink(),
      ],
    );
  }
}
