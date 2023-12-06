import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:onspace/features/tag_location/cubit/tag_location_cubit.dart';
import 'package:onspace/features/tag_location/cubit/tag_location_cubit.dart';

import '../../../../resources/common_widget/curved_card.dart';
import '../widgets/tag_card.dart';

class TagsLocationScreen extends StatefulWidget {
  const TagsLocationScreen({super.key});

  @override
  State<TagsLocationScreen> createState() => _TagsLocationScreenState();
}

class _TagsLocationScreenState extends State<TagsLocationScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  LocationData? currentLocation;

  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  void setCustomMarkerIcon() {
    ///current location icon
    getBytesFromAssets('assets/images/rider.png', 100).then(
          (markerIcon) =>
      {
        currentLocationIcon = BitmapDescriptor.fromBytes(markerIcon),
      },
    );

    setState(() {});
  }

  Future<void> getCurrentLocation() async {
    final location = Location();
    await location.getLocation().then(
          (location) {
        currentLocation = location;
      },
    );
    final googleMapController = await _controller.future;
    location.onLocationChanged.listen(
          (newLoc) {
        const tokenValue = 'sharedPreferences.getString(token)';
        final currLatitude = newLoc.latitude;
        final currLongitude = newLoc.longitude;

        if (currLatitude != null && currLongitude != null) {
          Future.delayed(Duration.zero, () {
            currentLocation = newLoc;
            googleMapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  zoom: 13.5,
                  target: LatLng(
                    newLoc.latitude!,
                    newLoc.longitude!,
                  ),
                ),
              ),
            );
          });
        }
      },
    );
  }

  @override
  void initState() {
    // double latitude = "sharedPreferences.getDouble("latitude") ?? 0";
    // double longitude = sharedPreferences.getDouble("longitude") ?? 0;
    const latitude = 0.0;
    const longitude = 0.0;
    currentLocation = LocationData.fromMap({
      'latitude': latitude,
      'longitude': longitude,
    });
    setCustomMarkerIcon();
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
          GoogleMap(
            zoomControlsEnabled: false,
            initialCameraPosition: currentLocation == null
                ? const CameraPosition(target: LatLng(0, 0), zoom: 10)
                : CameraPosition(
              target: LatLng(
                currentLocation!.latitude!,
                currentLocation!.longitude!,
              ),
              zoom: 13.5,
            ),
            markers: currentLocation != null
                ? {
              Marker(
                markerId: const MarkerId('currentLocation'),
                icon: currentLocationIcon,
                position: LatLng(
                  currentLocation!.latitude!,
                  currentLocation!.longitude!,
                ),
              ),
            }
                : {},
            onMapCreated: (mapController) {
              _controller.complete(mapController);
              setState(() {});
            },
          ),
          BlocBuilder<TagLocationCubit, TagLocationState>(
            builder: (context, state) {
              if(state is TagsLocationLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              else if(state is TagsLocationLoaded) {
                return Text("data");
              }
              else if(state is TagsLocationError) {
                return Text("error");
              }
              else {
                return Container();
              }
            },
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
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
                CurvedCard(
                    color: theme.colorScheme.primary,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 20, bottom: 20),
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
                                      padding:
                                      const EdgeInsets.only(left: 0),
                                      child: Card(
                                        color: Colors.white38,
                                        elevation: 0,
                                        margin: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(50),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 2,
                                            bottom: 2,
                                          ),
                                          child: Text("All",
                                              style: TextStyle(
                                                  color: theme.colorScheme
                                                      .tertiary,
                                                  fontSize: 14,
                                                  fontFamily: 'Spline',
                                                  fontWeight:
                                                  FontWeight.bold)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: 10),
                                      child: Card(
                                        color: Colors.white38,
                                        elevation: 0,
                                        margin: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(50),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 2,
                                            bottom: 2,
                                          ),
                                          child: Text("People",
                                              style: TextStyle(
                                                  color: theme.colorScheme
                                                      .tertiary,
                                                  fontSize: 14,
                                                  fontFamily: 'Spline',
                                                  fontWeight:
                                                  FontWeight.normal)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: 10),
                                      child: Card(
                                        color: Colors.white38,
                                        elevation: 0,
                                        margin: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(50),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 2,
                                            bottom: 2,
                                          ),
                                          child: Text("Items",
                                              style: TextStyle(
                                                  color: theme.colorScheme
                                                      .tertiary,
                                                  fontSize: 14,
                                                  fontFamily: 'Spline',
                                                  fontWeight:
                                                  FontWeight.normal)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: theme.hintColor,
                                      width: 1,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.more_horiz_rounded,
                                    color: theme.colorScheme.tertiary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: 2,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  return TagsCard(
                                      isRecent:
                                      index == 0 ? true : false);
                                })
                          ]),
                    )),
              ],
            ),
          ),
          // Positioned(
          //   bottom: 80,
          //   left: 10,
          //   right: 10,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Padding(
          //         padding: EdgeInsets.zero,
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Card(
          //               color: theme.colorScheme.secondary,
          //               elevation: 0,
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(50),
          //               ),
          //               margin: EdgeInsets.zero,
          //               child: Padding(
          //                 padding: const EdgeInsets.only(
          //                   left: 2,
          //                   right: 20,
          //                   top: 2,
          //                   bottom: 2,
          //                 ),
          //                 child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.start,
          //                   children: [
          //                     Container(
          //                       decoration: BoxDecoration(
          //                         color: theme.colorScheme.primary,
          //                         shape: BoxShape.circle,
          //                       ),
          //                       child: Padding(
          //                         padding: const EdgeInsets.all(6.0),
          //                         child: Icon(
          //                           Icons.add,
          //                           color: theme.colorScheme.tertiary,
          //                         ),
          //                       ),
          //                     ),
          //                     const SizedBox(
          //                       width: 10,
          //                     ),
          //                     Text(
          //                       'Add new tag',
          //                       style: TextStyle(
          //                         color: theme.colorScheme.tertiary,
          //                         fontSize: 14,
          //                         fontFamily: 'Spline',
          //                         fontWeight: FontWeight.w600,
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //             Card(
          //               color: theme.colorScheme.secondary,
          //               elevation: 0,
          //               margin: EdgeInsets.zero,
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(50),
          //               ),
          //               child: Padding(
          //                 padding: const EdgeInsets.only(
          //                   left: 2,
          //                   right: 20,
          //                   top: 2,
          //                   bottom: 2,
          //                 ),
          //                 child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.start,
          //                   children: [
          //                     Container(
          //                       decoration: BoxDecoration(
          //                         color: theme.colorScheme.primary,
          //                         shape: BoxShape.circle,
          //                       ),
          //                       child: Padding(
          //                         padding: const EdgeInsets.all(6.0),
          //                         child: Icon(
          //                           Icons.add,
          //                           color: theme.colorScheme.tertiary,
          //                         ),
          //                       ),
          //                     ),
          //                     const SizedBox(
          //                       width: 10,
          //                     ),
          //                     Text(
          //                       'Add new item',
          //                       style: TextStyle(
          //                         color: theme.colorScheme.tertiary,
          //                         fontSize: 14,
          //                         fontFamily: 'Spline',
          //                         fontWeight: FontWeight.w600,
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       CurvedCard(
          //           color: theme.colorScheme.primary,
          //           child: Padding(
          //             padding: const EdgeInsets.only(left: 10, right: 10,
          //                 top: 20, bottom: 20),
          //             child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Row(
          //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                     children: [
          //                       Row(
          //                         children: [
          //                           Padding(
          //                             padding: const EdgeInsets.only(left: 0),
          //                             child: Card(
          //                               color: Colors.white38,
          //                               elevation: 0,
          //                               margin: EdgeInsets.zero,
          //                               shape: RoundedRectangleBorder(
          //                                 borderRadius: BorderRadius.circular(50),
          //                               ),
          //                               child: Padding(
          //                                 padding: const EdgeInsets.only(
          //                                   left: 20,
          //                                   right: 20,
          //                                   top: 2,
          //                                   bottom: 2,
          //                                 ),
          //                                 child: Text("All",
          //                                     style: TextStyle(
          //                                         color: theme.colorScheme.tertiary,
          //                                         fontSize: 14,
          //                                         fontFamily: 'Spline',
          //                                         fontWeight: FontWeight.bold)),
          //                               ),
          //                             ),
          //                           ),
          //                           Padding(
          //                             padding: const EdgeInsets.only(left: 10),
          //                             child: Card(
          //                               color: Colors.white38,
          //                               elevation: 0,
          //                               margin: EdgeInsets.zero,
          //                               shape: RoundedRectangleBorder(
          //                                 borderRadius: BorderRadius.circular(50),
          //                               ),
          //                               child: Padding(
          //                                 padding: const EdgeInsets.only(
          //                                   left: 20,
          //                                   right: 20,
          //                                   top: 2,
          //                                   bottom: 2,
          //                                 ),
          //                                 child: Text("People",
          //                                     style: TextStyle(
          //                                         color: theme.colorScheme.tertiary,
          //                                         fontSize: 14,
          //                                         fontFamily: 'Spline',
          //                                         fontWeight: FontWeight.normal)),
          //                               ),
          //                             ),
          //                           ),
          //                           Padding(
          //                             padding: const EdgeInsets.only(left: 10),
          //                             child: Card(
          //                               color: Colors.white38,
          //                               elevation: 0,
          //                               margin: EdgeInsets.zero,
          //                               shape: RoundedRectangleBorder(
          //                                 borderRadius: BorderRadius.circular(50),
          //                               ),
          //                               child: Padding(
          //                                 padding: const EdgeInsets.only(
          //                                   left: 20,
          //                                   right: 20,
          //                                   top: 2,
          //                                   bottom: 2,
          //                                 ),
          //                                 child: Text("Items",
          //                                     style: TextStyle(
          //                                         color: theme.colorScheme.tertiary,
          //                                         fontSize: 14,
          //                                         fontFamily: 'Spline',
          //                                         fontWeight: FontWeight.normal)),
          //                               ),
          //                             ),
          //                           ),
          //                         ],
          //                       ),
          //                       const Spacer(),
          //                       Container(
          //                         decoration: BoxDecoration(
          //                           border: Border.all(
          //                             color: theme.hintColor,
          //                             width: 1,
          //                           ),
          //                           shape: BoxShape.circle,
          //                         ),
          //                         child: Icon(Icons.more_horiz_rounded,
          //                           color: theme.colorScheme.tertiary,),
          //                       ),
          //                     ],
          //                   ),
          //                   const SizedBox(
          //                     height: 15,
          //                   ),
          //                   ListView.builder(
          //                       shrinkWrap: true,
          //                       itemCount: 2,
          //                       padding: EdgeInsets.zero,
          //                       itemBuilder: (context, index){
          //                         return TagsCard(isRecent: index == 0 ? true : false);
          //                       })
          //                 ]),
          //           )),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

Future<Uint8List> getBytesFromAssets(String path, int width) async {
  final data = await rootBundle.load(path);
  final codec = await ui.instantiateImageCodec(
    data.buffer.asUint8List(),
    targetWidth: width,
  );
  final fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}
