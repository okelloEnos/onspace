// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class MapScreen extends StatelessWidget {
//   const MapScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<HomeBloc, HomeState>(
//         builder: (context, state) {
//           if (state is HomeActiveRequestAcceptedSuccess) {
//
//             double pickUpLatitude = double.parse(state.message.pickupLatitude ?? "0");
//             double pickUpLongitude = double.parse(state.message.pickupLongitude ?? "0");
//             double deliveryLatitude = double.parse(state.message.deliveryLatitude ?? "0");
//             double deliveryLongitude = double.parse(state.message.deliveryLongitude ?? "0");
//             int hasStop = state.message.hasStop ?? 0;
//             Stops deliveryStop = state.message.stops ?? Stops();
//             return  ParcelTrackingPage(
//               pickUpLocation: LatLng(pickUpLatitude ,pickUpLongitude),
//               deliveryLocation: LatLng(deliveryLatitude ,deliveryLongitude),
//             hasStop: hasStop,
//               deliveryStop: deliveryStop
//             );
//           }
//           else if(state is HomeActiveRequestProgress){
//             return Center(child: imagePlaceHolder(color: const Color(primaryColor)),);
//           }
//           else {
//             return const StaticMapView();
//           }
//         },
//       ),
//     );
//   }
// }
