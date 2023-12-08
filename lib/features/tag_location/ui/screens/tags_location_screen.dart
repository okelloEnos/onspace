import 'dart:async';

import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:onspace/features/tag_location/cubit/markers_cubit.dart';
import 'package:onspace/features/tag_location/cubit/tag_location_cubit.dart';
import 'package:onspace/features/tag_location/ui/widgets/tag_card.dart';
import 'package:onspace/resources/common_widget/circular_button_widget.dart';
import 'package:onspace/resources/common_widget/curved_card.dart';
import 'package:onspace/resources/common_widget/custom_container.dart';
import 'package:onspace/resources/common_widget/error_card_widget.dart';
import 'package:onspace/resources/common_widget/loading_widget.dart';

class TagsLocationScreen extends StatefulWidget {
  const TagsLocationScreen({super.key});

  @override
  State<TagsLocationScreen> createState() => _TagsLocationScreenState();
}

class _TagsLocationScreenState extends State<TagsLocationScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  LocationData? currentLocation;

  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  // void setCustomMarkerIcon() {
  //   ///current location icon
  //   getBytesFromAssets('assets/images/rider.png', 100).then(
  //     (markerIcon) => {
  //       currentLocationIcon = BitmapDescriptor.fromBytes(markerIcon),
  //     },
  //   );
  //
  //   setState(() {});
  // }

  Future<void> getCurrentLocation() async {
    final location = Location();
    await location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );
    final googleMapController = await _controller.future;
    if (currentLocation?.latitude != null &&
        currentLocation?.longitude != null) {
      Future.delayed(Duration.zero, () {
        currentLocation = currentLocation;
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 13.5,
              target: LatLng(
                currentLocation!.latitude!,
                currentLocation!.longitude!,
              ),
            ),
          ),
        );
      });
    }
  }

  @override
  void initState() {
    currentLocation = LocationData.fromMap({
      'latitude': 0.0,
      'longitude': 0.0,
    });
    // setCustomMarkerIcon();
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: currentLocation == null
          ? const Center(child: Text('Loading'))
          : Stack(
              children: [
                CustomGoogleMapMarkerBuilder(
                  customMarkers: context.watch<MarkersCubit>().state,
                  builder: (context, markers) {
                    if (markers == null) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return GoogleMap(
                      initialCameraPosition: currentLocation == null
                          ? const CameraPosition(
                              target: LatLng(0, 0),
                              zoom: 10,
                            )
                          : CameraPosition(
                              target: LatLng(
                                currentLocation!.latitude!,
                                currentLocation!.longitude!,
                              ),
                              zoom: 13.5,
                            ),
                      markers: markers,
                      compassEnabled: false,
                      mapToolbarEnabled: false,
                      tiltGesturesEnabled: false,
                      myLocationButtonEnabled: false,
                      myLocationEnabled: true,
                      rotateGesturesEnabled: false,
                      zoomControlsEnabled: false,
                      onMapCreated: (GoogleMapController controller) {},
                      // onMapCreated: _controller.complete,
                    );
                  },
                ),
                Positioned(
                  top: 100,
                  left: 10,
                  right: 10,
                  child: BlocBuilder<TagLocationCubit, TagLocationState>(
                    builder: (context, state) {
                      if (state is TagsLocationLoading) {
                        return const LoadingWidget(
                          loadingText: 'Loading tags and '
                              'their location...',
                        );
                      } else if (state is TagsLocationLoaded) {
                        final profileList = state.tagsLocation;
                        for (final profile in profileList) {
                          context
                              .read<MarkersCubit>()
                              .addMarker(context, profile);
                        }

                        return Container();
                      } else if (state is TagsLocationError) {
                        return ErrorCardWidget(
                          retry: () => context
                              .read<TagLocationCubit>()
                              .fetchTagsLocation(),
                          errorText: "An error occurred and we couldn't "
                              'fetch your tags and their location, Press the'
                              ' button and'
                              ' try again.',
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
                Positioned(
                  bottom: 80,
                  left: 10,
                  right: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Card(
                              color: theme.colorScheme.secondary,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              margin: EdgeInsets.zero,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 2,
                                  right: 20,
                                  top: 2,
                                  bottom: 2,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.primary,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6),
                                        child: Icon(
                                          Icons.add,
                                          color: theme.colorScheme.tertiary,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Add new tag',
                                      style: TextStyle(
                                        color: theme.colorScheme.tertiary,
                                        fontSize: 14,
                                        fontFamily: 'Spline',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              color: theme.colorScheme.secondary,
                              elevation: 0,
                              margin: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 2,
                                  right: 20,
                                  top: 2,
                                  bottom: 2,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.primary,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6),
                                        child: Icon(
                                          Icons.add,
                                          color: theme.colorScheme.tertiary,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Add new item',
                                      style: TextStyle(
                                        color: theme.colorScheme.tertiary,
                                        fontSize: 14,
                                        fontFamily: 'Spline',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: CurvedCard(
                          color: theme.colorScheme.primary,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 20,
                              bottom: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.zero,
                                          child: GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<MarkersCubit>()
                                                  .clearMarkers();
                                              context
                                                  .read<TagLocationCubit>()
                                                  .filterFetchedTagsLocation(
                                                    selectedFilter:
                                                        TagsLocationFilter.all,
                                                  );
                                            },
                                            child: Card(
                                              color: Colors.white38,
                                              elevation: 0,
                                              margin: EdgeInsets.zero,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  50,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  top: 2,
                                                  bottom: 2,
                                                ),
                                                child: Text(
                                                  'All',
                                                  style: TextStyle(
                                                    color: theme
                                                        .colorScheme.tertiary,
                                                    fontSize: 14,
                                                    fontFamily: 'Spline',
                                                    fontWeight: context
                                                                .watch<
                                                        TagLocationCubit>()
                                                                .filter ==
                                                            TagsLocationFilter
                                                                .all
                                                        ? FontWeight.bold
                                                        : FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<MarkersCubit>()
                                                  .clearMarkers();
                                              context
                                                  .read<TagLocationCubit>()
                                                  .filterFetchedTagsLocation(
                                                    selectedFilter:
                                                        TagsLocationFilter
                                                            .people,
                                                  );
                                            },
                                            child: Card(
                                              color: Colors.white38,
                                              elevation: 0,
                                              margin: EdgeInsets.zero,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  50,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  top: 2,
                                                  bottom: 2,
                                                ),
                                                child: Text(
                                                  'People',
                                                  style: TextStyle(
                                                    color: theme
                                                        .colorScheme.tertiary,
                                                    fontSize: 14,
                                                    fontFamily: 'Spline',
                                                    fontWeight: context
                                                                .watch<
                                                        TagLocationCubit>()
                                                                .filter ==
                                                            TagsLocationFilter
                                                                .people
                                                        ? FontWeight.bold
                                                        : FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<MarkersCubit>()
                                                  .clearMarkers();
                                              context
                                                  .read<TagLocationCubit>()
                                                  .filterFetchedTagsLocation(
                                                    selectedFilter:
                                                        TagsLocationFilter
                                                            .items,
                                                  );
                                            },
                                            child: Card(
                                              color: Colors.white38,
                                              elevation: 0,
                                              margin: EdgeInsets.zero,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  50,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  top: 2,
                                                  bottom: 2,
                                                ),
                                                child: Text(
                                                  'Items',
                                                  style: TextStyle(
                                                    color: theme
                                                        .colorScheme.tertiary,
                                                    fontSize: 14,
                                                    fontFamily: 'Spline',
                                                    fontWeight: context
                                                                .watch<
                                                        TagLocationCubit>()
                                                                .filter ==
                                                            TagsLocationFilter
                                                                .items
                                                        ? FontWeight.bold
                                                        : FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    CustomContainer(
                                      child: Padding(
                                        padding: const EdgeInsets.all(1),
                                        child: Icon(
                                          Icons.more_horiz_rounded,
                                          color: theme.colorScheme.tertiary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                BlocBuilder<TagLocationCubit, TagLocationState>(
                                  builder: (context, state) {
                                    if (state is TagsLocationLoading) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: theme.colorScheme.secondary,
                                        ),
                                      );
                                    } else if (state is TagsLocationLoaded) {
                                      final profileList = state.tagsLocation;

                                      return profileList.isEmpty
                                          ? Center(
                                              child: Text(
                                                "You don't have any tags",
                                                style: TextStyle(
                                                  color: theme
                                                      .colorScheme.tertiary,
                                                  fontSize: 14,
                                                  fontFamily: 'Spline',
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            )
                                          : ListView.builder(
                                              shrinkWrap: true,
                                              padding: EdgeInsets.zero,
                                              itemCount: profileList.length > 2
                                                  ? 2
                                                  : profileList.length,
                                              itemBuilder: (context, index) {
                                                return TagsCard(
                                                  userProfile:
                                                      profileList[index],
                                                  isRecent: index == 0,
                                                );
                                              },
                                            );
                                    } else if (state is TagsLocationError) {
                                      return Center(
                                        child: Text(
                                          'An error occurred and we '
                                          "couldn't fetch your tags and"
                                          ' their'
                                          ' location',
                                          style: TextStyle(
                                            color: theme.colorScheme.tertiary,
                                            fontSize: 14,
                                            fontFamily: 'Spline',
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 360,
                  left: 10,
                  right: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircularIconButton(
                        containerSize: 40,
                        child: Icon(
                          Icons.add,
                          color: theme.colorScheme.tertiary,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CircularIconButton(
                        containerSize: 40,
                        child: Icon(
                          Icons.remove,
                          color: theme.colorScheme.tertiary,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CircularIconButton(
                        containerSize: 40,
                        child: Transform.rotate(
                          angle: 1,
                          child: Icon(
                            Icons.navigation_outlined,
                            color: theme.colorScheme.tertiary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 10,
                  right: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircularIconButton(
                        containerSize: 40,
                        child: Icon(
                          Icons.search_rounded,
                          color: theme.colorScheme.tertiary,
                        ),
                      ),
                      CircularIconButton(
                        containerSize: 40,
                        child: Icon(
                          Icons.settings,
                          color: theme.colorScheme.tertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
