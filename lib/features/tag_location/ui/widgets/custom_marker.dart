import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:onspace/features/profile/ui/screens/profile_screens.dart';
import 'package:onspace/features/tag_location/data/model/profile.dart';
import 'package:onspace/resources/common_widget/circular_button_widget.dart';

class CustomMapMarker extends StatelessWidget {
  const CustomMapMarker({required this.file, required this.profile, super.key});
  final File file;
  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        Icon(
          Icons.location_on,
          color: theme.colorScheme.tertiary,
          size: 55,
        ),
        Positioned(
          left: 10,
          top: 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Container(
                    width: 30,
                    height: 30,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(file),
                        fit: BoxFit.fill,
                      ),
                      color: theme.colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    // child: Image.file(file)
                  ),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              CircularIconButton(
                containerColor: theme.colorScheme.tertiary,
                containerSize: 15,
                child: Icon(
                  Icons.school_outlined,
                  color: theme.colorScheme.secondary,
                  size: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
